import './main.css';
import { Elm } from './Main.elm';
import registerServiceWorker from './registerServiceWorker';
import Soundfont from 'soundfont-player';

const getAudioContext = function() {
  return new (window.AudioContext || window.webkitAudioContext)();
};

const app = Elm.Main.init({
  node: document.getElementById('root'),
  instrument: {},
  audioContext: getAudioContext(),
});

app.ports.playNote.subscribe(note => app.instrument.play(note));
app.ports.requestLoadSoundFont.subscribe(loadSoundFont);

function loadSoundFont() {
  const opts = { soundfont: 'FluidR3_GM' };
  const bank = 'electric_guitar_clean';

  if (!app.audioContext) {
    app.audioContext = getAudioContext();
  }

  Soundfont.instrument(app.audioContext, bank, opts).then(guitar => {
    app.instrument = guitar;
  });
}

registerServiceWorker();
