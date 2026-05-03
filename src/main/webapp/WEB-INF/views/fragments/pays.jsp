<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<option value="">-- Choisir un pays --</option>
<option value="France"        ${param.selected == 'France'         ? 'selected' : ''}>🇫🇷 France</option>
<option value="Madagascar"    ${param.selected == 'Madagascar'     ? 'selected' : ''}>🇲🇬 Madagascar</option>
<option value="Etat Unis"    ${param.selected == 'Etat Unis'     ? 'selected' : ''}>US Etat Unis</option>
<option value="Sénégal"       ${param.selected == 'Sénégal'        ? 'selected' : ''}>🇸🇳 Sénégal</option>
<option value="Côte d'Ivoire" ${param.selected == 'Côte d\'Ivoire' ? 'selected' : ''}>🇨🇮 Côte d'Ivoire</option>
<option value="Afrique du Sud" ${param.selected == 'Afrique du Sud' ? 'selected' : ''}>AF Afrique du Sud</option>
<option value="Cameroun"      ${param.selected == 'Cameroun'       ? 'selected' : ''}>🇨🇲 Cameroun</option>
<option value="Mali"          ${param.selected == 'Mali'           ? 'selected' : ''}>🇲🇱 Mali</option>
<option value="Maroc"         ${param.selected == 'Maroc'          ? 'selected' : ''}>🇲🇦 Maroc</option>
<option value="Algérie"       ${param.selected == 'Algérie'        ? 'selected' : ''}>🇩🇿 Algérie</option>
<option value="Tunisie"       ${param.selected == 'Tunisie'        ? 'selected' : ''}>🇹🇳 Tunisie</option>
<option value="Congo"         ${param.selected == 'Congo'          ? 'selected' : ''}>🇨🇬 Congo</option>
<option value="Belgique"      ${param.selected == 'Belgique'       ? 'selected' : ''}>🇧🇪 Belgique</option>
<option value="Canada"        ${param.selected == 'Canada'         ? 'selected' : ''}>🇨🇦 Canada</option>
<option value="Suisse"        ${param.selected == 'Suisse'         ? 'selected' : ''}>🇨🇭 Suisse</option>
<option value="Réunion"       ${param.selected == 'Réunion'        ? 'selected' : ''}>🇷🇪 Réunion</option>
<option value="Mayotte"       ${param.selected == 'Mayotte'        ? 'selected' : ''}>🇾🇹 Mayotte</option>