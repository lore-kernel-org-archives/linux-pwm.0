From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/1] pwm: mediatek: add longer period support
Date: Thu, 27 Feb 2020 13:33:14 +0100
Message-ID: <20200227123314.mkg6jqai64b3paxw@pengutronix.de>
References: <1582789610-23133-1-git-send-email-sam.shih@mediatek.com>
 <1582789610-23133-2-git-send-email-sam.shih@mediatek.com>
 <20200227080450.rkvwfjx6vikn5ls3@pengutronix.de>
 <1582797590.25607.10.camel@mtksdccf07>
 <20200227105244.orwitjst3wzoqcsq@pengutronix.de>
 <1582806427.27775.1.camel@mtksdccf07>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43955 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728964AbgB0MdQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 27 Feb 2020 07:33:16 -0500
Content-Disposition: inline
In-Reply-To: <1582806427.27775.1.camel@mtksdccf07>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sam Shih <sam.shih@mediatek.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-mediatek@lists.infradead.org, John Crispin <john@phrozen.org>, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org

Hello Sam,

On Thu, Feb 27, 2020 at 08:27:07PM +0800, Sam Shih wrote:
> > > 
> > > + /* The pwm source clock can be divided by 2^clkdiv. When the clksel  +
> > > * bit is set to 1, The final clock output needs to be divided by an +  *
> > > extra 1625.
> > > +  */
> > 
> > I'd write:
> > 
> > The source clock is divided by 2^clkdiv or iff the clksel bit is set by
> > 2^clkdiv + 1625.
> > 
> 
> Great, the comment is short and clear. 
> But maybe change “2^clkdiv + 1625” to “the product of 2^clkdiv and 1625”
> is clearer ?

Writing a formula in words isn't helpful. If my formula was wrong use
the right one. I wrote

	2^clkdiv + 1625

(which implicitly means (2^clkdiv) + 1625), if this is wrong write

	2^clkdiv * 1625

or whatever is the right one then. And use parenthesis if you doubt
clearness.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
