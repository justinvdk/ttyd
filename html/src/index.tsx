if (process.env.NODE_ENV === 'development') {
    require('preact/debug');
}
import 'whatwg-fetch';
import { h, render } from 'preact';
import { App } from './components/app';
import './style/index.scss';

// Nom right mouse so that tmux (or some other prog) can take care of it.
document.body.oncontextmenu = () => false;

render(<App />, document.body);
