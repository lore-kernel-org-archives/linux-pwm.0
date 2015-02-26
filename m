From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [alsa-devel] [PATCH 1/8] clk: add helper function clk_is_match()
Date: Thu, 26 Feb 2015 10:56:58 +0100
Message-ID: <1424944618.3073.6.camel@pengutronix.de>
References: <1424876018-17852-1-git-send-email-shawn.guo@linaro.org>
	 <1424876018-17852-2-git-send-email-shawn.guo@linaro.org>
	 <20150225172757.421.43718@quantum>
	 <20150226090256.GQ30445@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50344 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752193AbbBZJ5H (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 26 Feb 2015 04:57:07 -0500
In-Reply-To: <20150226090256.GQ30445@trinity.fluff.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: Mike Turquette <mturquette@linaro.org>, linux-pwm@vger.kernel.org, alsa-devel@alsa-project.org, Russell King <linux@arm.linux.org.uk>, kernel@pengutronix.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@codeaurora.org>, dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, linux-serial@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org

Am Donnerstag, den 26.02.2015, 09:02 +0000 schrieb Ben Dooks:
> On Wed, Feb 25, 2015 at 09:27:57AM -0800, Mike Turquette wrote:
[...]
> > From: Michael Turquette <mturquette@linaro.org>
> > Date: Wed, 25 Feb 2015 09:11:01 -0800
> > Subject: [PATCH] clk: introduce clk_is_match
> > 
> > Some drivers compare struct clk pointers as a means of knowing
> > if the two pointers reference the same clock hardware. This behavior is
> > dubious (drivers must not dereference struct clk), but did not cause any
> > regressions until the per-user struct clk patch was merged. Now the test
> > for matching clk's will always fail with per-user struct clk's.
> > 
> > clk_is_match is introduced to fix the regression and prevent drivers
> > from comparing the pointers manually.
> 
> small observaton, clk_is_same() is linguistically nicer.

How about clk_equal() ?

regards
Philipp

