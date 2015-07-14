From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [RFC PATCH 14/15] regulator: pwm: implement ->enable(),
 ->disable() and ->is_enabled methods
Date: Tue, 14 Jul 2015 13:02:22 +0200
Message-ID: <20150714130222.1bdfedc5@bbrezillon>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
	<1435738921-25027-15-git-send-email-boris.brezillon@free-electrons.com>
	<20150714105019.GR11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:39929 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751751AbbGNLC3 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Jul 2015 07:02:29 -0400
In-Reply-To: <20150714105019.GR11162@sirena.org.uk>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, linux-tegra@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Doug Anderson <dianders@google.com>

Hi Mark,

On Tue, 14 Jul 2015 11:50:19 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Wed, Jul 01, 2015 at 10:22:00AM +0200, Boris Brezillon wrote:
> > Implement the ->enable(), ->disable() and ->is_enabled methods and remove
> > the PWM call in ->set_voltage_sel().
> 
> This doesn't apply, please check and resend.

This series was made on top of Linus' tree (4.2-rc1 IIRC) and patch 14
and 15 were not meant to be applied without Thierry's approval (they
depend on other changes in the PWM framework).
I can rebase them on top of linux-next (or just on top of Linus'
4.2-rc2) if Thierry is okay with that, but I don't think rebasing them
on your regulator's for-next branch is a good idea.

Thierry, Mark, let me know what you prefer.

Thanks,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
