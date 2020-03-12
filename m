From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: pwm: sun4i: pwm-backlight not working since 5.6-rc1
Date: Thu, 12 Mar 2020 14:29:42 +0100
Message-ID: <20200312132942.2kfspvmoc3mxkdx4@pengutronix.de>
References: <6185b5540ca082d887d7d13330c9d938@pascalroeleven.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41497 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgCLN3x (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Mar 2020 09:29:53 -0400
Content-Disposition: inline
In-Reply-To: <6185b5540ca082d887d7d13330c9d938@pascalroeleven.nl>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Pascal Roeleven <dev@pascalroeleven.nl>
Cc: Thierry Reding <thierry.reding@gmail.com>, Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Philipp Zabel <p.zabel@pengutronix.de>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com

On Thu, Mar 12, 2020 at 01:22:13PM +0100, Pascal Roeleven wrote:
> Hi all,
> 
> I am working on adding an old A10 device to mainline and noticed an issue
> when testing on 5.5.8 vs master.
> 
> Since 5.6-rc1, I can't control the brightness of my LCD backlight anymore.
> The backlight stays on full brightness instead. I am controlling the
> brightness value via sysfs for testing.
> 
> I am not sure if this is a general pwm-sun4i issue or if it is related to
> the backlight. However I narrowed it down to one commit for pwm-sun4i:
> 
> fa4d81784681a26bcf7d2a43c6ac5cf991ef28f5
> 
> If I use pwm-sun4i.c from 5b090b430d750961305030232314b6acdb0102aa on
> master, the backlight works fine. Unfortunately, due to my lack of kernel
> experience, I can't see how the commit above broke it.

Hmm, I cannot see how fa4d81784681a26bcf7d2a43c6ac5cf991ef28f5 breaks
this. Looking at the output of

	git show -b fa4d81784681a26bcf7d2a43c6ac5cf991ef28f5

(i.e. ignoring whitespace changes) I don't see how the behaviour you're
reporting can be explained.

Are you sure that fa4d81784681a26bcf7d2a43c6ac5cf991ef28f5 is the bad
commit?

Can you install a tool to inspect register values and check how the
affected registers change if you switch kernel versions and/or pwm
settings?

(e.g.
	memtool md 0x1c20e00+0xc
)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
