From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH 01/10] pwm: lpc18xx_pwm: use pwm_set_chip_data
Date: Mon, 26 Oct 2015 18:58:18 -0300
Message-ID: <CAAEAJfD=Lvqx-4_SHJyhg9Q1T_CKhLaGYs+X_ttoVf_zh_Yvkg@mail.gmail.com>
References: <1445895161-2317-1-git-send-email-o.schinagl@ultimaker.com>
	<1445895161-2317-2-git-send-email-o.schinagl@ultimaker.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:33656 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752564AbbJZV6T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 26 Oct 2015 17:58:19 -0400
Received: by wijp11 with SMTP id p11so186815434wij.0
        for <linux-pwm@vger.kernel.org>; Mon, 26 Oct 2015 14:58:18 -0700 (PDT)
In-Reply-To: <1445895161-2317-2-git-send-email-o.schinagl@ultimaker.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Olliver Schinagl <o.schinagl@ultimaker.com>
Cc: Olliver Schinagl <oliver@schinagl.nl>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Joachim Eastwood <manabian@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Olliver Schinagl <oliver+list@schinagl.nl>, linux-pwm@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Ariel D'Alessandro <ariel@vanguardiasur.com.ar>

(+ Ariel)

Hi Oliver,

Not sure why there's some many people in Cc for such a silly change.
I guess you are using get_maintainers.pl on the entire patchset and get
this rather long list.

IMO, the value of submitting patches as part of a larger series is to b=
e able to
push patches that need to be applied in some given order, or otherwise
have some kind of logical relationship between them.

However, this is not the case: it's just a very small change and has
no relation to the rest of the patches in the series.
I think a simple standalone patch would be better here.

Also, get_maintainer.pl is just a hint, and not meant to be used as-is.
In particular, you are missing the driver's author.

On 26 October 2015 at 18:32, Olliver Schinagl <o.schinagl@ultimaker.com=
> wrote:
> From: Olliver Schinagl <oliver@schinagl.nl>
>
> The lpc18xx driver currently manipulates the pwm_device struct direct=
ly
> rather then using the pwm_set_chip_data. While the current method may
> save a clock cycle or two, it is more obvious that data is set to the
> chip pointer (especially since it is only a single int holding struct=
=2E
>
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> ---
>  drivers/pwm/pwm-lpc18xx-sct.c | 11 +++++++----
>  drivers/pwm/pwm-sun4i.c       | 11 +++++++++++
>  2 files changed, 18 insertions(+), 4 deletions(-)
>

=2E..and this diffstat is obviously fishy.
--=20
Ezequiel Garc=C3=ADa, VanguardiaSur
www.vanguardiasur.com.ar
