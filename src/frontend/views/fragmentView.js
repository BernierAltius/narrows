const html = require("choo/html");

const extend = require("../extend");

const addImageView = (state, send) => html`
  <div class="add-image">
    <input type="text"
           oninput=${ e => { send("updateNewImageUrl", { value: e.target.value }); } }
           value=${ state.newImageUrl || "" } />
    <button onclick=${ () => { send("addImage", { src: state.newImageUrl }); } }>Add Image</button>
  </div>
`;

const participantListView = (fragmentId, participants) => html`
  <aside class="participants">
    <h2>Participants</h2>
    <ul>
      ${ participants.map(p => html`<li><a href="/read/${ fragmentId }/${ p.token }">${ p.name }</a></li>`) }
    </ul>
  </aside>
`;

const markForCharacter = (state, send) => html`
  <div>
    Mark text for Mildred:
    <button onclick=${ () => send("markTextForCharacter", { characters: [{id: 1, name: "Mildred Mayfield"}] }) }>Mark</button>
  </div>
`;

const loadedFragmentView = (state, send) => html`
  <div>
    <h1>Fragment</h1>

    <nav>
      <a href="/narrations/${ state.fragment.narrationId }">Narration</a> ⇢
        Fragment ${ state.fragment.id }
    </nav>

    <main class="page-aside">
      <section>
        <input class="fragment-title"
               type="text"
               placeholder="Title"
               oninput=${ e => { send("updateFragmentTitle", { value: e.target.value }); } }
               value=${ state.fragment.title || "" } />

        <div class="editor-container">
          ${ state.editor.wrapper }
        </div>

        ${ addImageView(state, send) }

        ${ markForCharacter(state, send) }

        <div class="btn-row">
          <button class="btn" onclick=${ () => { send("saveFragment", { fragmentId: state.params.fragmentId }); }}>Save</button>
          <button class="btn btn-default" onclick=${ () => { send("publishFragment", { fragmentId: state.params.fragmentId }); }}>Publish</button>
        </div>
      </section>

      ${ participantListView(state.fragment.id, state.fragment.participants) }
    </main>
  </div>
`;

const loadingFragmentView = () => html `
  <div>
    Loading…
  </div>
`;

const fragmentView = (state, prev, send) => {
    const fragmentId = parseInt(state.params.fragmentId, 10);

    if (state.fragment.id !== fragmentId) {
        send("getFragment", { fragmentId: state.params.fragmentId });
        return loadingFragmentView(state, send);
    }
    return loadedFragmentView(state, send);
};

module.exports = fragmentView;
