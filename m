From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH v2 0/2] Add support for NXP LPC18xx PWM/SCT
Date: Thu, 20 Aug 2015 16:51:36 -0300
Message-ID: <CAAEAJfCyZUNadthZ_3-scqv0f8Rjf4dd=fg8Rhqt0xfdoDF9XQ@mail.gmail.com>
References: <1438828307-14641-1-git-send-email-ariel@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:33568 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576AbbHTTvi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 20 Aug 2015 15:51:38 -0400
Received: by lbbsx3 with SMTP id sx3so30773259lbb.0
        for <linux-pwm@vger.kernel.org>; Thu, 20 Aug 2015 12:51:37 -0700 (PDT)
In-Reply-To: <1438828307-14641-1-git-send-email-ariel@vanguardiasur.com.ar>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Joachim Eastwood <manabian@gmail.com>, Ariel D'Alessandro <ariel@vanguardiasur.com.ar>

Thierry,

On 5 August 2015 at 23:31, Ariel D'Alessandro
<ariel@vanguardiasur.com.ar> wrote:
> This patch series adds support for NXP LPC18xx PWM/SCT.
>
> NXP LPC SoCs family, which includes LPC18xx/LPC43xx, provides a State
> Configurable Timer (SCT) which can be configured as a Pulse Width Mod=
ulator.
> Other SoCs in that family may share the same hardware.
>
> Patchset is based on tag next-20150723 of the linux-next repository.
> It has been successfully tested on a Hitex LPC4350 Evaluation Board.
>
> Changes since v1:
> * Added "sct" in DT compatible string and driver's name.
> * Allowed period changes when there's only one channel requested.
>
> Ariel D'Alessandro (2):
>   pwm: NXP LPC18xx PWM/SCT driver
>   DT: pwm: Add NXP LPC18xx PWM/SCT binding documentation
>
>  .../devicetree/bindings/pwm/lpc1850-sct-pwm.txt    |  20 +
>  drivers/pwm/Kconfig                                |  12 +
>  drivers/pwm/Makefile                               |   1 +
>  drivers/pwm/pwm-lpc18xx-sct.c                      | 465 +++++++++++=
++++++++++
>  4 files changed, 498 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/lpc1850-sct=
-pwm.txt
>  create mode 100644 drivers/pwm/pwm-lpc18xx-sct.c
>
> --
> 1.9.1
>

Any news about this driver?

--=20
Ezequiel Garc=C3=ADa, VanguardiaSur
www.vanguardiasur.com.ar
