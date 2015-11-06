From: Olliver Schinagl <o.schinagl@ultimaker.com>
Subject: Re: [PATCH 04/10] pwm: core: use bitops
Date: Fri, 06 Nov 2015 15:49:25 +0100
Message-ID: <563CBDF5.50904@ultimaker.com>
References: <1445895161-2317-1-git-send-email-o.schinagl@ultimaker.com> <1445895161-2317-5-git-send-email-o.schinagl@ultimaker.com> <20151106144635.GA8418@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:32889 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbbKFOt2 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Nov 2015 09:49:28 -0500
Received: by wijp11 with SMTP id p11so31579949wij.0
        for <linux-pwm@vger.kernel.org>; Fri, 06 Nov 2015 06:49:26 -0800 (PST)
In-Reply-To: <20151106144635.GA8418@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Olliver Schinagl <oliver@schinagl.nl>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Joachim Eastwood <manabian@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Olliver Schinagl <oliver+list@schinagl.nl>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hey Thierry,

but why have the bit macro at all then :)

But that choice I guess I leave to you, as it's your section, I know=20
some submaintainers prefer it and want it to be used, so I guess it's=20
something in general kernel wide that should be desided on, BIT() macro=
=20
preferred or not.

Olliver

On 06-11-15 15:46, Thierry Reding wrote:
> On Mon, Oct 26, 2015 at 10:32:35PM +0100, Olliver Schinagl wrote:
>> From: Olliver Schinagl <oliver@schinagl.nl>
>>
>> The pwm header defines bits manually while there is a nice bitops.h =
with
>> a BIT() macro. Use the BIT() macro to set bits in pwm.h
>>
>> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
>> ---
>>   include/linux/pwm.h | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
> I don't think this is a useful change. The BIT() macro needs the same
> number of characters to type at the expense of requiring an additiona=
l
> include.
>
> Thierry

--=20
Met vriendelijke groeten, Kind regards, =E4=B8=8E=E4=BA=B2=E5=88=87=E7=9A=
=84=E9=97=AE=E5=80=99

Olliver Schinagl
Software Engineer
Research & Development
Ultimaker B.V.
