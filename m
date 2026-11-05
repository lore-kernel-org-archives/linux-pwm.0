Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=85.215.255.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793901718;
	b=gkv6QeM3d2j+hGzwEd6ysRUjPBYZvgAfzkMYPVr0/CtYdg5R4KOfi5GOjbip7ePDkEcm
	 vEKQkdDaB1amSBebKf+Ion8JdJqJYVkDVYpnGbIGpVNzFwEaDs0c8+lGGTci8cU/S6wi9
	 dxyEs1iekWQIP2ymdJAAy0Le2IjBDNgJbF9JKWdtSCRhq2slDik8LE8/HdSNRakXOCFWb
	 gsEJj/TukTueS3pTkb273c3uSSlSR6k0nYZ+EjQzMNl6bRWR6mmIaslYp/pzySGRNbuNL
	 TdFh39bgiUkDjRAB2ca+B/2IueHenoYzpqIrTTyYGqA1jPicjDwBVN4EJRLmYxKbrfQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901718;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=AphafxKjSuT1XmPYm5OalWDPJuZimE2NC2/tLgcX0Lg=;
	b=ALd6XP13ZEVdrF8O0a2/rfaFAIcM1Ko6aXZ5T8qGr+FcmH221c6m0orswaDT/1p28NsJ
	 4NclxdXDs9RPHoCp552EVAT2wifkA5mCU5NyjjnhIex4GPWTa4b/KnNuU209IlHlpB/I5
	 F15SxGMYcq1dK6IV0RPnAglCyDd2xgZBJcU4STdMod1iFFOOUGuClYpir2UDu4DevRiQU
	 qZdtgwT/laH6HLtfJ4dSxVEWPjJmfKj6h/7NKDpfzn4CGaXjBvZuWCYbGaHB7mk+ShJyZ
	 KgkiXPhunV0JO351nfzKT7cvCJGcHxbNlQvSPcChkFs3P+nDwe8IqJEdKCW+5HNkcvA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goldelico.com;
	spf=pass smtp.mailfrom=goldelico.com;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=ewJIny1H;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b="K/FNia72";
	arc=fail smtp.remote-ip=85.215.255.51
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E05F606A330;
	Thu,  5 Nov 2026 18:01:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E05F606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=ewJIny1H;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=K/FNia72
ARC-Seal: i=1; a=rsa-sha256; t=1793901699; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=A6dLYLyk+g3Ohy+w4y9KTyDogoNA4cmAbA1L6uRepejBayj3zjY96SOa0UBOl8OVoo
    D7jV2LD5XNYF4fLKoGjwNfR8rtgSqERESwOzN3HbK5m+X3/DRzCW6XWeYHsvWIKxn1qX
    hH+CGyhJaVXGM89+44tlXWMBjHjX+o8LVFH9UK7UhSfmDwT0K7ANmSmXuk7HcSnBmb8N
    hZsYcUreu4X9ahzxwphbCYPOibJ8Ua5m2dw2wQiGRvq7caAam7UkbU/O8hmo5rwojP/i
    Fmj6LSUaDrU82/OmEbYixkmUVwLIVYlB/wgevvj4KT9MfsmnAav4N/m+NYd7GUxOnIpV
    KMpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793901699;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=AphafxKjSuT1XmPYm5OalWDPJuZimE2NC2/tLgcX0Lg=;
    b=aAX2KqZC0R9pNz+DEkAC2sGA8QASJ3DK2ZpP2zQBKM+G9pAukmNihsHbWeD/b1V2Vh
    BcfbBESumXCd1tfpgpMzzCVjLQIJVx16F8meSOrH5e49ksYdMJpPxsZp9A3e8QuyFVYM
    p8K71Z3rJypNwWgBkz0Pr7uYptlcoBplNQf1fC5tlmSVsJCdwhi/q+XoHbX5LYiGw8Pv
    HjXn1XaHTW4+Udcl5J3e9PJDI6hcDdHyldDICjFnSoKQNAiVaDl5O3xcJAv9a52VSVW3
    w8TW2UpnXV4qpcZhK5sxSIg1tHXpYTiW9AyCD+8xSBO0rYsp0lTPLIIhinSbbXB/o1Pa
    5/vQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793901699;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=AphafxKjSuT1XmPYm5OalWDPJuZimE2NC2/tLgcX0Lg=;
    b=ewJIny1HlMt4AlyD4OcS2IeUA1xWKRR8uPf3j/XlcuUhZ0KNZVVvf2eZNQIu9sjOTz
    H4WvL5e8bUq5RcAex38qipmajUBcV6Ib83w3AGBKNxNnL5deNQfZu1fYLe+QQuW/5/eT
    oMb3SNYNdAhqCOxGef1XY5iwKHBIM63XHj56cIiV2R4aZ+m+tLjhpCY1t35IAUXO7al2
    1Ba53m8j/rQAtvq0SvuE9TFx1yUPU/0Qy7RvJz7DiRKTQwrHJN6jiyPsJeOCdx06j1py
    tgm360c8yAoWdQq0Am0+KeMXxieT1eZQaNpWf8+4HuLa4oYJXt/Jubwqic4JagQrHcHb
    KdOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793901699;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=AphafxKjSuT1XmPYm5OalWDPJuZimE2NC2/tLgcX0Lg=;
    b=K/FNia724/JWYZXesG0UBL+KjXktst3AeSe7qM70T9ym04AkttdfLylg5KVVcYEvii
    lyxJdgeeiP2A0eonzdAQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrV25oGlMiNUOZNJoYXSTSpu/Ae46f1NE9YxyvD"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Qb56a22A5I1ckHH
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Thu, 5 Nov 2026 19:01:38 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.10\))
Subject: Re: [PATCH v3 0/2] pwm: Add the Ingenic X1600 PWM controller
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20261102201325.29507-1-olivier@mgcrea.io>
Date: Thu, 5 Nov 2026 19:01:07 +0100
Cc: =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Paul Cercueil <paul@crapouillou.net>,
 linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F04C8980-F5D1-4828-9174-7780B794C4D2@goldelico.com>
References: <20261102201325.29507-1-olivier@mgcrea.io>
To: Olivier Louvignes <olivier@mgcrea.io>
X-Mailer: Apple Mail (2.3826.700.81.1.10)

Hi,

I have started to review and compare with our (old) pwm x1600 driver
which is based on some vendor driver. It appears to somehow support
DMA.

> Am 02.11.2026 um 21:13 schrieb Olivier Louvignes <olivier@mgcrea.io>:
>=20
> The Ingenic X1600 has a PWM controller of its own, separate from the =
TCU
> timers that pwm-jz4740 drives on the earlier Ingenic SoCs. This adds =
its
> binding and a driver built on the waveform callbacks.
>=20
> Changes in v3, after Uwe's review of v2 (thanks):
> - Krzysztof's Reviewed-by on the binding, unchanged since v2.
> - Kconfig and Makefile entries in alphabetical order.
> - The programming manual's link in the driver's header.
> - The limitations comment says what 0 and 100% do: the channel is
> switched off, its output held at its idle level.
> - No mod_devicetable.h include; bitops.h for fls64().
> - X1600_PWM_MAX_COUNT from FIELD_MAX(). PRESCALE is four bits wide, =
but
> the manual reserves its values from 8 up (section 13.4.7), as a
> comment now says.
> - A comment on why x1600_pwm_ns() cannot overflow.
> - The prescaler computed without a loop; it matches v2's loop on =
300,000
> random waveforms.
> - A channel that is off reads back as 0 or 100% by its idle level, =
over
> the period its counts give, and as disabled only with both counts
> zero. Its initial level plays no part then.
> - .write_waveform() no longer waits for BUSY, the clock rate is taken
> exclusively and cached at probe, and the chip is atomic.
> - Fixed: v2 changed the divider or the initial level of a running
> channel by switching it off and on again. A channel switched off
> finishes its period, though, and switched on again before that, it
> keeps its old word, so the new waveform was lost. v3 writes the
> divider, then loads the initial level and the word through the update
> register, running or not.
>=20
> Uwe's questions about the registers, measured on the R1's channel 0
> through /dev/mem, with its pin sampled through the GPIO port about =
every
> microsecond and the clock divided by 128 (a 10 ms period):
> - IDL is the level while off, and nothing else: set on a running
> channel, it changes nothing; on a channel that is off, the output
> follows it at once. So it does not depend on the offset, and every
> write now sets it.
> - INL is loaded with the word: written alone it changes nothing, and
> with an update the new level starts with the next period.
> - A word written without an update changes nothing. After an update,
> BUSY stays set until the period ends (8.7 ms in one run), and a second
> word written while BUSY is set replaces the first, which never shows.
> - The divider takes effect as soon as it is written, in the middle of =
a
> period.
> - ENC clears EN at once, but the output finishes its period before it
> goes to the idle level.
> - An update on a channel that is off keeps BUSY set; ENS then loads =
the
> word, and BUSY clears at the end of the first period.
>=20
> v3 itself was tested on the R1 with PWM_DEBUG, sampling the pin the =
same
> way. Through pwm-backlight, 30, 60 and 99% measured 30.8, 59.8 and =
99.0%
> high, and 0 and 100% switched the channel off with its output held low
> and high. Through sysfs on channel 0, with the backlight unbound, all =
on
> a running channel: a new duty cycle; a period from 100 us to 1 ms, so =
a
> new divider, after which it ran at 1 ms and 25%; the polarity =
inversed,
> so a new initial level, after which it was high 75% of the time; then
> 0 and 100% inversed, and off. PWM_DEBUG reported nothing.
>=20
> The X1600 has no device tree upstream yet; its support is being posted
> one subsystem at a time.
>=20
> v2: https://lore.kernel.org/r/20261025191624.9219-1-olivier@mgcrea.io
> v1: https://lore.kernel.org/r/20261025084643.93167-1-olivier@mgcrea.io
>=20
> Olivier Louvignes (2):
> dt-bindings: pwm: Add the Ingenic X1600 PWM controller
> pwm: Add a driver for the Ingenic X1600 PWM controller
>=20
> .../bindings/pwm/ingenic,x1600-pwm.yaml       |  47 +++
> MAINTAINERS                                   |   6 +
> drivers/pwm/Kconfig                           |  11 +
> drivers/pwm/Makefile                          |   1 +
> drivers/pwm/pwm-ingenic-x1600.c               | 289 ++++++++++++++++++

Here I have a first question about the naming scheme. It does not seem =
to be common
to have pwm-[vendor]-chip.c

The only exceptions I can see are pwm-bcm-*-c, pwm-intel-lgm.c, =
pwm-renesas-tpu.c.

Since there is already pwm-jz4740.c without vendor-infix, I'd suggest to =
simply use
pwm-x1600.c unless the pwm maintainers disagree.

> 5 files changed, 354 insertions(+)
> create mode 100644 =
Documentation/devicetree/bindings/pwm/ingenic,x1600-pwm.yaml
> create mode 100644 drivers/pwm/pwm-ingenic-x1600.c

More to come after trying to test...

BR and thanks,
Nikolaus

