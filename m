From: Milo Kim <woogyom.kim@gmail.com>
Subject: Re: [PATCH v2 1/4] ARM: dts: sun8i: Add PWM pin in H3
Date: Thu, 1 Sep 2016 21:51:00 +0900
Message-ID: <85db83b5-a98d-dfc2-5082-8b235f2185c2@gmail.com>
References: <20160831082520.25962-1-woogyom.kim@gmail.com>
 <20160831082520.25962-2-woogyom.kim@gmail.com>
 <CAGb2v66etp0AsYvs8n3MgBXehqV=kwkSnuq=Kt=aLtH4xvcDkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33473 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752127AbcIAMvH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 1 Sep 2016 08:51:07 -0400
In-Reply-To: <CAGb2v66etp0AsYvs8n3MgBXehqV=kwkSnuq=Kt=aLtH4xvcDkA@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Rob Herring <robh+dt@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, devicetree <devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, linux-pwm@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>

On 08/31/2016 05:33 PM, Chen-Yu Tsai wrote:
>> +                       pwm0_pin_a: pwm0@0 {
> This is the only possible configuration. You can drop the _a suffix
> from the label, and @0 from the node name.

OK, thanks for your review.

Best regards,
Milo
