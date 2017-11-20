From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2] pwm: imx: Allow keeping the PWM active during suspend
Date: Mon, 20 Nov 2017 21:06:15 -0200
Message-ID: <CAOMZO5C62nkpdEkAkj3vZRMsC_jUB7X4uU_UuV_OuxSkvgQnUA@mail.gmail.com>
References: <1511015768-14140-1-git-send-email-festevam@gmail.com> <20171120211932.ro3ybgo6ih2542m2@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:34145 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751191AbdKTXGQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Nov 2017 18:06:16 -0500
In-Reply-To: <20171120211932.ro3ybgo6ih2542m2@rob-hp-laptop>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Russell King <linux@arm.linux.org.uk>, linux-pwm@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Rob,

On Mon, Nov 20, 2017 at 7:19 PM, Rob Herring <robh@kernel.org> wrote:

> Seems to me the default behavior should be LEDs are off in suspend and
> you'd add a property to enable them if desired.

Are you suggesting that I set the MX3_PWMCR_STOPEN bit unconditionally?

I see some old version of vendor driver that does exactly that:
http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/arch/arm/plat-mxc/pwm.c?h=imx_2.6.35_11.09.01

I can do that and then we do not need to add an extra device tree property.

Thanks
