Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F33F313E34;
	Tue, 11 Aug 2026 05:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786424693; cv=none; b=Fcn1luIkL3qegBhSTs20220Ej6mNcP8LT9pAU8+PifzOKGXMZj0SROopI9Ze/KjS50w0xYAW2qAZpg5Bk+z56+86sm5rqrQ4cw0Uyabs7iO7mXBSkSI/1ofqJedfVgYxPaVvTfmQDW2StaE2PyNRXnd4i657RQ0Ysi5rMvaEiHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786424693; c=relaxed/simple;
	bh=OhA3CjKIhhsTqf9YfgPMk5SCnr/FnHSFiGeF7/GcbgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KaomPIIrDGLD+PNZZjuVxM29cZVMeMVcIcUa7at50M2RQ33yd5a6QVHCA/udR+DLOkLlc4KWdo88fiQphdLL+wVQcdVdQZXtnijuxUt/1J1WFKRpfjmF/L/pcoM/iMaglr3ly/thXZG5wUPEjXPkaGdw+5U5WGNUSrUM1zfCBp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UP0uzuNh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UP0uzuNh"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 713A61F000E9;
	Tue, 11 Aug 2026 05:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786424692;
	bh=8olbanpy/fSKAyXMqDm5t9N7+MfGxWrHDfiMZjVnNy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UP0uzuNhyhd9t4hPFCqnV7L/rsiCJtqK0MvNgNn3OvJTGGSChG4jYCRPEg4LsZY2C
	 NPcCD8LstpPV41dv/NO6YtNyHzW6WOd/CAAPiuliB243v/KOG++kdvMM8vVfUDDQOA
	 DWtE5dkoRtQck2HvvE+S65PX3G0Kyi6ZWg+8LylsHDC0PyyKaphkVYfzmTKNuVhVD3
	 eH30tFQ53wjNnn7fWjSqeLqv7EKD0QbSOubZMj+kKuh2eoMcilBnptNjbsxoXMS1yR
	 HBvH1PKQI+pTmCrC3zje/2yJI0+EY640bt+o7lRnDmdVad+GxbaP67yOMPthmcq6Z1
	 DkhSrtqKqln5A==
Date: Tue, 11 Aug 2026 07:04:49 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Francis Laniel <laniel_francis@privacyrequired.com>
Cc: Michal Wilczynski <m.wilczynski@samsung.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
	Alexandre Courbot <acourbot@nvidia.com>, Boqun Feng <boqun@kernel.org>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tools@kernel.org
Subject: Re: [PATCH v3] rust: pwm: replace `core::mem::zeroed` with
 `pin_init::zeroed`
Message-ID: <anqsTVj5QGYGiEQ9@monoceros>
References: <20260603160910.159307-1-laniel_francis@privacyrequired.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ro3vl7mzahsvodny"
Content-Disposition: inline
In-Reply-To: <20260603160910.159307-1-laniel_francis@privacyrequired.com>


--ro3vl7mzahsvodny
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] rust: pwm: replace `core::mem::zeroed` with
 `pin_init::zeroed`
MIME-Version: 1.0

Hello,

On Wed, Jun 03, 2026 at 07:09:09PM +0300, Francis Laniel wrote:
> All types in `bindings` implement `Zeroable` if they can, so use
> `pin_init::zeroed` instead of relying on `unsafe` code.
>=20
> If this ends up not compiling in the future, something in bindgen or on
> the C side changed and is most likely incorrect.
>=20
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1189
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Acked-by: Michal Wilczynski <m.wilczynski@samsung.com>
> Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>

Applied to

	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for=
-next

for the 7.3 merge window.

b4 behaved strange on that patch:

	$ b4 am -s -l -t -3 20260603160910.159307-1-laniel_francis@privacyrequired=
=2Ecom
	Grabbing thread from lore.kernel.org/all/20260603160910.159307-1-laniel_fr=
ancis@privacyrequired.com/t.mbox.gz
	Analyzing 2 messages in the thread
	Looking for additional code-review trailers on lore.kernel.org
	Analyzing 23 code-review messages
	Checking attestation on all messages, may take a moment...
	---
	  =E2=9C=93 [PATCH v3] rust: pwm: replace `core::mem::zeroed` with `pin_in=
it::zeroed`
	    + Link: https://patch.msgid.link/20260603160910.159307-1-laniel_franci=
s@privacyrequired.com
	    + Signed-off-by: Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org>
	  ---
	  =E2=9C=93 Signed: DKIM/privacyrequired.com
	---
	Total patches: 1
	---
	NOTE: some trailers ignored due to from/email mismatches:
	    ! Trailer: Suggested-by: Benno Lossin <lossin@kernel.org>
	     Msg From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
	    ! Trailer: Acked-by: Michal Wilczynski <m.wilczynski@samsung.com>
	     Msg From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
	    ! Trailer: Signed-off-by: Francis Laniel <laniel_francis@privacyrequir=
ed.com>
	     Msg From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
	    ! Trailer: Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
	     Msg From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
	NOTE: Rerun with -S to apply them anyway
	Preparing fake-am for v3: rust: pwm: replace `core::mem::zeroed` with `pin=
_init::zeroed`
	  range: 2707b9df955d..81c3f2b030a1
	Preared a fake commit range for 3-way merge (2707b9df955d..81c3f2b030a1)
	---
	 Link: https://patch.msgid.link/20260603160910.159307-1-laniel_francis@pri=
vacyrequired.com
	 Base: applies clean to current tree
	       git checkout -b v3_20260603_laniel_francis_privacyrequired_com HEAD
	       git am -3 ./v3_20260603_laniel_francis_rust_pwm_replace_core_mem_ze=
roed_with_pin_init_zeroed.mbx

I didn't research what went wrong there and the trailer made it into the
patch anyhow and adding -S doesn't change the patch. I added the
tools@k.o mailing list to Cc:, maybe someone there wants to debug that.

Best regards and thanks for your contribution,
Uwe

--ro3vl7mzahsvodny
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmp6rW4ACgkQj4D7WH0S
/k5X3gf/QUmCyjMrC2Fk6jUUaUmXgE6LT16a6QZbJ8dmdXdmrkS3p3mxsAxoN8Y9
3/1tYxROZ53L/w7b6se8OyJn3BhceXxtMBm9etU0yZq4ghNNCozZs9X8JQbcbWTw
DW6TZ6/me7SzDeKWauRqQ4i0iKNqLTjMW60kNTJ45j8emOe8omzyAr7Yb6/lTz2V
sWxelJ4Ej+h6SDfpu6OY/S6UfpkU/jKL69N4zkTN5TvLPZFA8sV8zLMYddsBKf24
NW0qwIeIRG7qzq2SQnk+eZOai60fkrFKS0b3RxzB1bMs+i2EQgHkL3j6k5j8XVaT
qNIvRLX+4YqQjcJdSzmw82tEe0YdMQ==
=Dcui
-----END PGP SIGNATURE-----

--ro3vl7mzahsvodny--
