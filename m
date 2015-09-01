From: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
Subject: Re: [PATCH v2 0/2] Add support for NXP LPC18xx PWM/SCT
Date: Tue, 1 Sep 2015 10:02:11 -0300
Message-ID: <55E5A1D3.4050507@vanguardiasur.com.ar>
References: <1438828307-14641-1-git-send-email-ariel@vanguardiasur.com.ar>
 <CAAEAJfCyZUNadthZ_3-scqv0f8Rjf4dd=fg8Rhqt0xfdoDF9XQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:33746 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752877AbbIANCR (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 1 Sep 2015 09:02:17 -0400
Received: by qgp105 with SMTP id 105so39940482qgp.0
        for <linux-pwm@vger.kernel.org>; Tue, 01 Sep 2015 06:02:16 -0700 (PDT)
In-Reply-To: <CAAEAJfCyZUNadthZ_3-scqv0f8Rjf4dd=fg8Rhqt0xfdoDF9XQ@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Joachim Eastwood <manabian@gmail.com>


El 20/08/15 a las 16:51, Ezequiel Garcia escribi=C3=B3:
> Thierry,
>=20
> On 5 August 2015 at 23:31, Ariel D'Alessandro
> <ariel@vanguardiasur.com.ar> wrote:
>> This patch series adds support for NXP LPC18xx PWM/SCT.
>>
>> NXP LPC SoCs family, which includes LPC18xx/LPC43xx, provides a Stat=
e
>> Configurable Timer (SCT) which can be configured as a Pulse Width Mo=
dulator.
>> Other SoCs in that family may share the same hardware.
>>
>> Patchset is based on tag next-20150723 of the linux-next repository.
>> It has been successfully tested on a Hitex LPC4350 Evaluation Board.
>>
>> Changes since v1:
>> * Added "sct" in DT compatible string and driver's name.
>> * Allowed period changes when there's only one channel requested.
>>
>> Ariel D'Alessandro (2):
>>   pwm: NXP LPC18xx PWM/SCT driver
>>   DT: pwm: Add NXP LPC18xx PWM/SCT binding documentation
>>
>>  .../devicetree/bindings/pwm/lpc1850-sct-pwm.txt    |  20 +
>>  drivers/pwm/Kconfig                                |  12 +
>>  drivers/pwm/Makefile                               |   1 +
>>  drivers/pwm/pwm-lpc18xx-sct.c                      | 465 ++++++++++=
+++++++++++
>>  4 files changed, 498 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pwm/lpc1850-sc=
t-pwm.txt
>>  create mode 100644 drivers/pwm/pwm-lpc18xx-sct.c
>>
>> --
>> 1.9.1
>>
>=20
> Any news about this driver?
>=20

Ping on this.
