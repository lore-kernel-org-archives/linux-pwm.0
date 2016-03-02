From: Joachim Eastwood <manabian@gmail.com>
Subject: Re: [PATCH v2] pwm: pwm-lpc18xx-sct: test clock rate to avoid
 division by 0
Date: Thu, 3 Mar 2016 00:28:29 +0100
Message-ID: <CAGhQ9Vw+JoRv2vtiJ8m4NMnnYtC8t3okbDN=3DAUQMj78YxArw@mail.gmail.com>
References: <1456959443-10032-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:33087 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106AbcCBX2a (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Mar 2016 18:28:30 -0500
In-Reply-To: <1456959443-10032-1-git-send-email-wsa@the-dreams.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Ariel D'Alessandro <ariel@vanguardiasur.com.ar>

Hi Wolfram,

On 2 March 2016 at 23:57, Wolfram Sang <wsa@the-dreams.de> wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> The clk API may return 0 on clk_get_rate, so we should check the result before
> using it as a divisor.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/pwm/pwm-lpc18xx-sct.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
> index 9163085101bc94..9861fed4e67d04 100644
> --- a/drivers/pwm/pwm-lpc18xx-sct.c
> +++ b/drivers/pwm/pwm-lpc18xx-sct.c
> @@ -360,6 +360,11 @@ static int lpc18xx_pwm_probe(struct platform_device *pdev)
>         }
>
>         lpc18xx_pwm->clk_rate = clk_get_rate(lpc18xx_pwm->pwm_clk);
> +       if (!lpc18xx_pwm->clk_rate) {
> +               dev_err(&pdev->dev, "pwm clock has no frequency\n");
> +               ret = -EINVAL;
> +               goto disable_pwmclk;
> +       }

Acked-by: Joachim Eastwood <manabian@gmail.com>

Thanks for fixing this.


regards,
Joachim Eastwood
