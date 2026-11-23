Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795467155;
	b=A9pdS0PAZYWXKDPglEOMWhCskkLHnurkfPD+9TiInNNE4VYUXN/liZA1YuKZ9FdmJLJ8
	 zM2wXtZuxkbxhmIg+9TIgrsav43XRbdjKd9Idje4xSWeZOGka3VlQgWwFRdOetwioHMDx
	 q7PaEs7bpsmXF8/f/Or2OUOj/SlMczYO7lW5xEVhqL7UYowJbcOHoxYTmGNwmO3iI9pYA
	 W0r5sjAMu4P/W822EJRNVQEm4U+CO+VNdbIWk6trA343ASpLJjFn4zk1sY9CmeWDShW7l
	 +6v8zKJXFKQ24djHHyTDAK7qShPMz0PT9dSgpDxLZDAWmM0+yWNUgFmZArdnAhqZlMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795467155;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=fksJyEcnalo6jb/77jNJkfTc1PGgVk2uV8ZWMr9EGV0=;
	b=RLf0kzDyxAIkA3QxJttm+oWYoO2YvCkFpnpIWafxBxvuGfgN0c42QHmXMfs+5zVb7nHx
	 l5kNETNPIaGF3XXUKy9/oAcBHTcwpA7j9sCDkzRdQ+Fcrfp6cO8JFTMp2rPnrcS58SP3j
	 pa2HNn8AvXOAC4I2rd7IywoYMnjNVnTwvfZYvMbYJE9Wn52EquSyOPwKzW4cgfkcty6SI
	 EULTkfU994GdxtdWyJw8b0jx2lzG44mOxk2s1ItOhF355Rv7926WrHZ/WF+vykmdBRPOa
	 98Wv17/nc/AlOwzt6llxWlFECcJu7aAAZp0xNirVeP2KLTPcoZzdr2p0Kz1LojSnLmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CKTYim9b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 59C7E606A321;
	Mon, 23 Nov 2026 20:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CKTYim9b
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 183631F000D0;
	Mon, 23 Nov 2026 20:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795467154;
	bh=fksJyEcnalo6jb/77jNJkfTc1PGgVk2uV8ZWMr9EGV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CKTYim9bo57X3lLqJNpjcn4nFFi+OU4uyDtvREyDbORALz85hyB/EX2WLAQVlOSZD
	 Bp/suq09MjzYEJ5/naC7w2V3WowWbepV06dZLYuIys1XwOoHdsYBaL67MMgi5ntYi/
	 NSZYS8AWIbPTh8IYC5i/S/VQVCOJYridPEPsmffoeMHU7yBatIWkAhBrAu+msTDVZd
	 rksb8ZRVuvFZGSQT+3VAQTcgRXSMCLiogJ7r7GZEce2EzBSB2n52vEih0IbqPM4jjg
	 jb/uHs/L2PJPD2+YruTzMNUsoE5OG54I0UM3o9fo3RnyXJ5JmA3o20vV63d/u1j3BO
	 veYo4KbxvoosA==
Date: Mon, 23 Nov 2026 21:52:31 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Manush Prajwal <manushprajwal555@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: tiehrpwm: fix copy-paste error in obsolete DT
 binding fallback
Message-ID: <awSm7G-UanPOS_ZQ@monoceros>
References: <artTMprq3aNbVrLN@monoceros>
 <6abb8db0.721b4d7a.30484d.cb00@mx.google.com>
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rbx3embdugogtuhb"
Content-Disposition: inline
In-Reply-To: <6abb8db0.721b4d7a.30484d.cb00@mx.google.com>


--rbx3embdugogtuhb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: tiehrpwm: fix copy-paste error in obsolete DT
 binding fallback
MIME-Version: 1.0

Hello,

On Tue, Sep 29, 2026 at 03:36:40PM +0530, Manush Prajwal wrote:
> Hi Uwe,
>=20
> Thanks for the quick review and for digging up the Fixes commit.
>=20
> > Looks right, I guess it needs:
> > Fixes: ae5200d22716 ("pwm: pwm-ti*: Get the clock from the PWMSS parent=
 when using old bindings")
> >=20
> > I wonder: Did you find this because you still use the old bindings, or
> > by code inspection somehow? If the latter, maybe it's time to drop the
> > handling instead?
>=20
> This was found purely by code inspection during a review of the PWM
> drivers, not from running older bindings on actual hardware.
>=20
> Given that this fallback in pwm-tiehrpwm has been effectively broken ever
> since commit ae5200d22716 was merged in 2014 without anyone noticing or
> reporting it, it seems very likely that nobody relies on this obsolete
> binding anymore.
>=20
> I would be happy to send a patch dropping the obsolete binding handling
> instead (from pwm-tiehrpwm, or from both pwm-tiehrpwm and pwm-tiecap if
> you prefer keeping them consistent).
>=20
> Or if you'd rather keep backward compatibility, I can send a v2 of this
> fix with the Fixes: tag included.
>=20
> Which direction would you prefer?

I think dropping the compat handling is fine. I didn't check if
according to the binding, this compat handling is still ok. If yes, this
needs deprecation, too. I wouldn't touch the tiecap driver for now, as
(AFAIU) there is no such breakage and keeping the compat handling there
isn't a burden.

Best regards
Uwe

--rbx3embdugogtuhb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmsEp4sACgkQj4D7WH0S
/k6dAgf9EYLJB+F/YORYQ9Um8ddDE4Wk+2BRr6QGRQY/sjVXNIlOaY/xaM6okXqc
HfkXC8zBkG211Hjdl5fq+8eY3ayY8JkBb59W8z4IJiQv1mMN9ogG21VHbSIPvRCI
ovd7WiUpyuCJuHeVc/5RDfY8/IriAX1rl++VMn46GPA7z9ORwCJojG5NEzSzwhGx
zhVMeneDGQPOBexHcatWxyKv4WQa4j54RcrqZ9QYORc5iLFUUQDZg2klRRxNKV4r
AeSXkHVFY5qIiYiauv0StwKjZXNsBEpPw9epGU/XckMC9E7/rMEzwQaVXu32N3Tq
g+HJODpM4gENNxDOnN2b/2hoyG9m8Q==
=cbvy
-----END PGP SIGNATURE-----

--rbx3embdugogtuhb--
