From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [RFC PATCH 15/15] regulator: pwm: properly initialize the
 ->state field
Date: Tue, 14 Jul 2015 13:03:53 +0200
Message-ID: <20150714130353.5f5d9d69@bbrezillon>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
	<1435738921-25027-16-git-send-email-boris.brezillon@free-electrons.com>
	<20150714105155.GS11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:40000 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752084AbbGNLD5 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Jul 2015 07:03:57 -0400
In-Reply-To: <20150714105155.GS11162@sirena.org.uk>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, linux-tegra@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Doug Anderson <dianders@google.com>

On Tue, 14 Jul 2015 11:51:55 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Wed, Jul 01, 2015 at 10:22:01AM +0200, Boris Brezillon wrote:
> > The ->state field is currently initialized to 0, thus referencing the
> > voltage selector at index 0, which might not reflect the current voltage
> > value.
> 
> This looks like it'll need reworking on top of Lee's recent changes to
> implement continuous voltage support for PWM regulators - we may be
> calculating the values to set dynamically at runtime.

Yep, I was planning on doing that in the next iteration, but I'd like
to have Thierry's feedback before sending a new version.


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
