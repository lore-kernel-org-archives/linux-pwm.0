From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [RFC PATCH 00/15] pwm: add support for atomic update
Date: Wed, 01 Jul 2015 23:57:57 +0200
Message-ID: <3250976.mr9RMtjrdC@diego>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:43191 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752880AbbGAV6Q (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Wed, 1 Jul 2015 17:58:16 -0400
In-Reply-To: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Alexandre Courbot <gnurou@gmail.com>, linux-fbdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Bryan Wu <cooloney@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Doug Anderson <dianders@google.com>, Mark Brown <broonie@kernel.org>, Richard Purdie <rpurdie@rpsys.net>, Jingoo Han <jingoohan1@gmail.com>, linux-tegra@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org

Hi Boris,

Am Mittwoch, 1. Juli 2015, 10:21:46 schrieb Boris Brezillon:
> Hello Thierry,
> 
> This series adds support for atomic PWM update, or ITO, the capability
> to update all the parameters of a PWM device (enabled/disabled, period,
> duty and polarity) in one go.
> 
> This implementation is still experimental, and I may have missed some key
> aspect, so any feedback are welcome.
> 
> Also note that I haven't protected the state update with any locking.
> That's because the existing config does not protect against concurrent
> access to a requested PWM device (see the pwm_config implementation).
> I guess the PWM framework assume the user will implement the proper locking
> scheme if it has to concurrently access the device.
> 
> The 5 first patches prepare the addition of the pwm_state concept, which
> will be used to allow atomic updates.
> The following patches introduce the pwm_state struct, initial state
> retrieval and atomic update concepts.
> 
> Patches 12 and 13 are showing how one can implement the initial state
> retrieval and atomic update features in a PWM driver (in this specific
> case I implemented it in the rockchip driver).
> 
> The last 2 patches are making use of those changes to improve the
> pwm-regulator driver (initializing the regulator state based on the
> initial PWM state).

at first I got very strange readings (very wrong values and wrong polarity), 
which resulted from the issues I pointed out in the replies to individual 
patches. After fixing these, the pwm read-back now returns exactly the expected 
values :-) .

And with the original voltage table from the Chromeos-devicetrees, the pwm-
regulator also returns the expected 1.2V that coreboot initially set.


Heiko
