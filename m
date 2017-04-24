From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v5 1/4] gpio: mvebu: Add limited PWM support
Date: Mon, 24 Apr 2017 11:15:24 +0200
Message-ID: <CACRpkdYeJkc8g0A6TXF3NO=jCZZvVpQ4kTPHg5=BriHbpN_-9g@mail.gmail.com>
References: <20170409180931.4884-1-ralph.sennhauser@gmail.com>
 <20170409180931.4884-2-ralph.sennhauser@gmail.com> <20170412163128.5c985a26@free-electrons.com>
 <20170412151932.GE7023@lunn.ch> <20170421111952.54978e80@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:36773 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1167709AbdDXJP0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Apr 2017 05:15:26 -0400
Received: by mail-io0-f170.google.com with SMTP id p80so66469639iop.3
        for <linux-pwm@vger.kernel.org>; Mon, 24 Apr 2017 02:15:26 -0700 (PDT)
In-Reply-To: <20170421111952.54978e80@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Ralph Sennhauser <ralph.sennhauser@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Alexandre Courbot <gnurou@gmail.com>, Russell King <linux@armlinux.org.uk>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Gregory Clement <gregory.clement@free-electrons.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

On Fri, Apr 21, 2017 at 11:19 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:

> I clearly don't want to block this, but I believe this is a very good
> illustration of why stable DT bindings simply don't work. We are
> realizing here that having each GPIO bank represented as a separate DT
> node doesn't work, because this blinking functionality is not per GPIO
> bank, but global to all GPIO banks.
>
> I am totally fine with compromise, and having things simple first, and
> extend them later if needed. But this stable DT binding rule makes this
> quite impossible: what is a compromise today might put you in big
> troubles tomorrow.

Really "stable bindings" I never believed in. It's just a pipe dream.

Well they might become stable when the system is "finished"
whenever that happens.

I think a better rationale is that of the IETF:
"rough consensus and running code", make deployed DTs work,
if they are not deployed, or only getting deployed together with the
kernel, changing the bindings are not a problem.

Yours,
Linus Walleij
