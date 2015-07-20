From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [RFC PATCH 06/15] pwm: define a new pwm_state struct
Date: Mon, 20 Jul 2015 12:01:16 +0200
Message-ID: <20150720120116.2358b829@bbrezillon>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
	<1435738921-25027-7-git-send-email-boris.brezillon@free-electrons.com>
	<20150720080458.GG29614@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:46629 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752272AbbGTKBT (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jul 2015 06:01:19 -0400
In-Reply-To: <20150720080458.GG29614@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, linux-tegra@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Doug Anderson <dianders@google.com>

On Mon, 20 Jul 2015 10:04:59 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Wed, Jul 01, 2015 at 10:21:52AM +0200, Boris Brezillon wrote:
> [...]
> > diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> [...]
> > +struct pwm_state {
> > +	unsigned int		period; 	/* in nanoseconds */
> > +	unsigned int		duty_cycle;	/* in nanoseconds */
> > +	enum pwm_polarity	polarity;
> > +};
> 
> No need for the extra padding here.

What do you mean by "extra padding" ?
I just reused the indentation used in the pwm_device struct.

Would you prefer something like that ?

struct pwm_state {
	unsigned int period; 		/* in nanoseconds */
	unsigned int duty_cycle;	/* in nanoseconds */
	enum pwm_polarity polarity;
};

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
