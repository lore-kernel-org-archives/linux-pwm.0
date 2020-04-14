From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: About rounding in the clk framework [Was: Re: [PATCH 4/7] pwm:
 jz4740: Improve algorithm of clock calculation]
Date: Tue, 14 Apr 2020 11:24:12 +0200
Message-ID: <20200414092412.scsl6sekikc2tsv5@pengutronix.de>
References: <1565648183.2007.3@crapouillou.net>
 <20190813052726.g37upws5rlvrszc4@pengutronix.de>
 <1565694066.1856.1@crapouillou.net>
 <20190813123331.m4ttfhcgt6wyrcfi@pengutronix.de>
 <1565700448.1856.2@crapouillou.net>
 <20190813140903.rdwy7p3mhwetmlnt@pengutronix.de>
 <1565799035.1984.0@crapouillou.net>
 <20190814173218.zhg4se3pppano5m3@pengutronix.de>
 <1571662077.3.1@crapouillou.net>
 <20200212072911.nstwj7dgpvceebpy@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58351 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437562AbgDNJYk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Apr 2020 05:24:40 -0400
Content-Disposition: inline
In-Reply-To: <20200212072911.nstwj7dgpvceebpy@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Stephen Boyd <sboyd@kernel.org>, Michael Turquette <mturquette@baylibre.com>
Cc: linux-pwm@vger.kernel.org, od@zcrc.me, Artur Rojek <contact@artur-rojek.eu>, Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>, Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de, linux-clk@vger.kernel.org

Hello Stephen, hello Michael,

On Wed, Feb 12, 2020 at 08:29:11AM +0100, Uwe Kleine-König wrote:
> Can you please explain what is the reason why clk_round_rate_up/down()
> is a bad idea? Would it help to create a patch that introduces these
> functions to get the discussion going?

I didn't get any feedback on my mail. Are you to busy working on more
important stuff? Is the answer so obvious that you don't consider it
worth your time to answer?

Looking a bit through the code I see there are two callbacks hwclks can
provide to implement rounding (determine_rate and round_rate). The docs
for both use the term "return the closes rate actually supported". Does
that mean "round-closest" is already the official policy and other
strategies in lowlevel drivers are a bug?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
