/*
 * Copyright (c) 2020 De Staat der Nederlanden, Ministerie van Volksgezondheid, Welzijn en Sport.
 *  Licensed under the EUROPEAN UNION PUBLIC LICENCE v. 1.2
 *
 *  SPDX-License-Identifier: EUPL-1.2
 */

import Combine
import UIKit

/// @mockable
protocol HelpManaging {
    var questions: [HelpQuestion] { get }
}

final class HelpManager: HelpManaging {

    let questions: [HelpQuestion]

    init(theme: Theme) {

        questions = [
            HelpQuestion(
                theme: theme,
                question: "Kan de app mijn locatie zienpp mijn locatie zien?",
                answer: "Nee, de app ziet via Bluetooth alleen of je in de buurt bent van andere mensen die de app ook op hun telefoon hebben. Bluetooth is niet gekoppeld aan je locatie, dus de app kan niet zien waar je bent.Bluetooth is puur bedoeld om een draadloze verbinding te maken tussen twee apparaten die dicht bij elkaar zijn. Zoals je telefoon en een geluidsbox of koptelefoon."),
            HelpQuestion(
                theme: theme,
                question: "Hoe kan de app anoniem zijn?",
                answer: "Nee, de app ziet via Bluetooth alleen of je in de buurt bent van andere mensen die de app ook op hun telefoon hebben. Bluetooth is niet gekoppeld aan je locatie, dus de app kan niet zien waar je bent.Bluetooth is puur bedoeld om een draadloze verbinding te maken tussen twee apparaten die dicht bij elkaar zijn. Zoals je telefoon en een geluidsbox of koptelefoon."),
            HelpQuestion(
                theme: theme,
                question: "Wanneer krijg ik een melding van de app? ",
                answer: "Nee, de app ziet via Bluetooth alleen of je in de buurt bent van andere mensen die de app ook op hun telefoon hebben. Bluetooth is niet gekoppeld aan je locatie, dus de app kan niet zien waar je bent.Bluetooth is puur bedoeld om een draadloze verbinding te maken tussen twee apparaten die dicht bij elkaar zijn. Zoals je telefoon en een geluidsbox of koptelefoon."),
            HelpQuestion(
                theme: theme,
                question: "Werkt Bluetooth door muren heen?",
                answer: "Nee, de app ziet via Bluetooth alleen of je in de buurt bent van andere mensen die de app ook op hun telefoon hebben. Bluetooth is niet gekoppeld aan je locatie, dus de app kan niet zien waar je bent.Bluetooth is puur bedoeld om een draadloze verbinding te maken tussen twee apparaten die dicht bij elkaar zijn. Zoals je telefoon en een geluidsbox of koptelefoon."),
            HelpQuestion(
                theme: theme,
                question: "Hoeveel stroom verbruikt de app?",
                answer: "Nee, de app ziet via Bluetooth alleen of je in de buurt bent van andere mensen die de app ook op hun telefoon hebben. Bluetooth is niet gekoppeld aan je locatie, dus de app kan niet zien waar je bent.Bluetooth is puur bedoeld om een draadloze verbinding te maken tussen twee apparaten die dicht bij elkaar zijn. Zoals je telefoon en een geluidsbox of koptelefoon.")
        ]
    }
}
