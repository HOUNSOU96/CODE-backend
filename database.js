"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.db = void 0;
const promise_1 = __importDefault(require("mysql2/promise"));
exports.db = await promise_1.default.createConnection({
    host: 'localhost',
    user: 'code_user',
    password: 'holy96H@',
    database: 'code_db'
});
console.log('Connecté à MySQL avec succès !');
