From: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Subject: Re: [PATCHv2 1/2] gpio: mvebu: fix blink counter register selection
Date: Fri, 9 Jun 2017 10:03:22 +0200
Message-ID: <20170609100322.765adf7f@gmail.com>
References: <20170601121826.14685-1-richard.genoud@gmail.com>
        <20170601121826.14685-2-richard.genoud@gmail.com>
        <CACRpkdbRN3pgNqUJXHimpMjSOMeZepjxACveTSVzYJWneM9hOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35035 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751540AbdFIID0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Jun 2017 04:03:26 -0400
In-Reply-To: <CACRpkdbRN3pgNqUJXHimpMjSOMeZepjxACveTSVzYJWneM9hOQ@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Richard Genoud <richard.genoud@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thierry Reding <thierry.reding@gmail.com>

On Fri, 9 Jun 2017 09:37:55 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Thu, Jun 1, 2017 at 2:18 PM, Richard Genoud
> <richard.genoud@gmail.com> wrote:
> 
> > The blink counter A was always selected because 0 was forced in the
> > blink select counter register.
> > The variable 'set' was obviously there to be used as the register
> > value, selecting the B counter when id==1 and A counter when id==0.
> >
> > Tested on clearfog-pro (Marvell 88F6828)
> >
> > Fixes: 757642f9a584 ("gpio: mvebu: Add limited PWM support")
> > Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> > Reviewed-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
> > Signed-off-by: Richard Genoud <richard.genoud@gmail.com>  
> 
> Patch applied for fixes.
> 
> It appears this will clash with patches on the development branch :(

Hi Linus,

The commit 2233bf7a92e7 ("gpio: mvebu: switch to regmap for register
access") which you likely mean breaks gpio-keys, reported about an hour
ago, so you might just want to drop that one for now instead as it
needs mor work anyway.

Ralph
