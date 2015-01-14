From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/7] gpio: mvebu: Fix probe cleanup on error
Date: Wed, 14 Jan 2015 14:05:04 +0100
Message-ID: <CACRpkdbc9U5u_jS1VPZh86jw51z8jLoeCF=wENdBjAGSv1vnaA@mail.gmail.com>
References: <1420846493-31647-1-git-send-email-andrew@lunn.ch>
	<1420846493-31647-3-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:43943 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187AbbANNFF (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Jan 2015 08:05:05 -0500
Received: by mail-ie0-f181.google.com with SMTP id rl12so8551301iec.12
        for <linux-pwm@vger.kernel.org>; Wed, 14 Jan 2015 05:05:04 -0800 (PST)
In-Reply-To: <1420846493-31647-3-git-send-email-andrew@lunn.ch>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Imre Kaloz <kaloz@openwrt.org>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>

On Sat, Jan 10, 2015 at 12:34 AM, Andrew Lunn <andrew@lunn.ch> wrote:

> Ensure that when there is an error during probe that the gpiochip is
> removed and the generic irq chip is removed.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Patch applied.

Yours,
Linus Walleij
