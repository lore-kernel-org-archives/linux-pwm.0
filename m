From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 1/1] pwm: mediatek: add longer period support
Date: Sun, 8 Mar 2020 21:18:11 +0100
Message-ID: <20200308201811.hlac57s3h4p4cgev@pengutronix.de>
References: <1583230755-25986-1-git-send-email-sam.shih@mediatek.com>
 <1583230755-25986-2-git-send-email-sam.shih@mediatek.com>
 <1a3a523e-62ff-e380-c67b-12f742d348ea@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51823 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgCHUS2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 8 Mar 2020 16:18:28 -0400
Content-Disposition: inline
In-Reply-To: <1a3a523e-62ff-e380-c67b-12f742d348ea@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Sam Shih <sam.shih@mediatek.com>, Thierry Reding <thierry.reding@gmail.com>, John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello,

On Sat, Mar 07, 2020 at 10:28:36PM +0100, Matthias Brugger wrote:
> On 03/03/2020 11:19, Sam Shih wrote:
> > The pwm clock source could be divided by 1625 with PWM_CON
> > BIT(3) setting in mediatek hardware.
> > 
> > This patch add support for longer pwm period configuration,
> > which allowing blinking LEDs via pwm interface.
> 
> Is this a fix? In this case please provide a Fixes tag with the commit ID which
> introduced the bug.

I'd say it qualifies as a fix if without it a request with a long period
returns success but isn't properly implemented. Otherwise it's only a
new feature.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
