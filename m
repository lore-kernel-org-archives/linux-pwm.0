From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH linux-pwm/for-next] pwm: renesas-tpu: remove support for sh7372
Date: Thu, 24 Nov 2016 14:26:12 +0100
Message-ID: <CAMuHMdXwPJ3=jBz3-J7j-gGYtM_Oi7ZDdkq6M0s39aAByzpEhQ@mail.gmail.com>
References: <1479993552-10518-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1479993552-10518-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Thierry Reding <thierry.reding@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Linux PWM List <linux-pwm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

On Thu, Nov 24, 2016 at 2:19 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Remove support for the SH7372 (SH-Mobile AP4) from the renesas-tpu driver.
>
> Commit edf4100906044225 ("ARM: shmobile: sh7372 dtsi: Remove Legacy file")
> removes this SoC from the kernel in v4.1.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
