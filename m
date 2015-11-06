From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 04/10] pwm: core: use bitops
Date: Fri, 6 Nov 2015 23:36:44 +0200
Message-ID: <CAHp75VdCoM5ZtMhwt8emC8GtFEuguEXYWZCJgT4hTBcMA7yQ-A@mail.gmail.com>
References: <1445895161-2317-1-git-send-email-o.schinagl@ultimaker.com>
	<1445895161-2317-5-git-send-email-o.schinagl@ultimaker.com>
	<20151106144635.GA8418@ulmo>
	<563CBDF5.50904@ultimaker.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-yk0-f173.google.com ([209.85.160.173]:36819 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965993AbbKFVgp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Nov 2015 16:36:45 -0500
In-Reply-To: <563CBDF5.50904@ultimaker.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Olliver Schinagl <o.schinagl@ultimaker.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Olliver Schinagl <oliver@schinagl.nl>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Joachim Eastwood <manabian@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Olliver Schinagl <oliver+list@schinagl.nl>, linux-pwm@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>

On Fri, Nov 6, 2015 at 4:49 PM, Olliver Schinagl
<o.schinagl@ultimaker.com> wrote:
> Hey Thierry,
>
> but why have the bit macro at all then :)

=46or my opinion, it's good to use in new code, or when you have this
change as a continuation of bigger series.
Though, others might have a different one :-)

>
> But that choice I guess I leave to you, as it's your section, I know =
some
> submaintainers prefer it and want it to be used, so I guess it's some=
thing
> in general kernel wide that should be desided on, BIT() macro preferr=
ed or
> not.
>
> Olliver
>
>
> On 06-11-15 15:46, Thierry Reding wrote:
>>
>> On Mon, Oct 26, 2015 at 10:32:35PM +0100, Olliver Schinagl wrote:
>>>
>>> From: Olliver Schinagl <oliver@schinagl.nl>
>>>
>>> The pwm header defines bits manually while there is a nice bitops.h=
 with
>>> a BIT() macro. Use the BIT() macro to set bits in pwm.h
>>>
>>> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
>>> ---
>>>   include/linux/pwm.h | 7 ++++---
>>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> I don't think this is a useful change. The BIT() macro needs the sam=
e
>> number of characters to type at the expense of requiring an addition=
al
>> include.
>>
>> Thierry
>
>
> --
> Met vriendelijke groeten, Kind regards, =E4=B8=8E=E4=BA=B2=E5=88=87=E7=
=9A=84=E9=97=AE=E5=80=99
>
> Olliver Schinagl
> Software Engineer
> Research & Development
> Ultimaker B.V.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



--=20
With Best Regards,
Andy Shevchenko
