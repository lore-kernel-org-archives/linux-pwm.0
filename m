From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v2] pwm: imx: set can_sleep flag for imx_pwm
Date: Fri, 23 May 2014 17:03:22 +0800
Message-ID: <20140523090321.GA2650@dragon>
References: <1400834488-2660-1-git-send-email-shawn.guo@freescale.com>
 <20140523084359.GD20155@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bl2lp0204.outbound.protection.outlook.com ([207.46.163.204]:53050
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751236AbaEWJDy (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Fri, 23 May 2014 05:03:54 -0400
Content-Disposition: inline
In-Reply-To: <20140523084359.GD20155@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Liu Ying <Ying.Liu@freescale.com>

On Fri, May 23, 2014 at 10:43:59AM +0200, Uwe Kleine-K=F6nig wrote:
> On Fri, May 23, 2014 at 04:41:28PM +0800, Shawn Guo wrote:
> > The .config() hook imx_pwm_config() calls clk APIs like clk_prepare=
()
> > and clk_get_rate(), which might sleep, so we need to set can_sleep =
flag
> > on pwm_chip.
> Wasn't there a bug that was fixed or at least made more obvious with
> this change? Is it worth mentioning in the commit log?

The bug should be the one same as what we fixed on pwm-mxs[1].  But I
did not try to trigger it on pwm-imx myself, because it's obvious.

Shawn

[1] http://article.gmane.org/gmane.linux.pwm/570
