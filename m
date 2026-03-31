Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9260A386C3E;
	Tue, 31 Mar 2026 07:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774942242; cv=none; b=NoIWj+u8a2yL16GvSbk7+bbMIeUR2V8LFN3lFRK2pc0hRkpUY0HKlMVTJtSEx/5ndnutggObLDEW3/92AawzEFfy8DwU7mzNNJm6tWFppB1Bmro8BWVkSxNLCSDoHHR9L8TrgWSn2VjZZ8BhupMyQPG17TuAHi3t+2nOpOJ8/CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774942242; c=relaxed/simple;
	bh=U3dS6xRa9SbmQHbsFSrnkvBrohW5VIqKMx3/x7hEwHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QujRrirFWHj6wmdjB15MNss84dt7rqiP3SMW1KG6nChcc9VqFVJGrIxtoWXqAnJXf6YiD4391qdPvNhIQtgDhg488RBeAQ/UsM9Au6wdhdKj5VENr4QyuJ5rVP8O0J75t5hQL+pGyltfkC4lS4NVeL4WIb76PqREVIvHGDXE+0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0hFsY7f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0hFsY7f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E11D2C19424;
	Tue, 31 Mar 2026 07:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774942242;
	bh=U3dS6xRa9SbmQHbsFSrnkvBrohW5VIqKMx3/x7hEwHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I0hFsY7fGH7wLTHvGO26wlrymBQX5wU4+60Lt83OYPsuesi4iXhUK8JEJEvNIeMgM
	 SnsFYXb3sDuQOEvGaHTcRT4KO1SwINQ9hXetsnylCE+ocfSrJw+5vnmhw4mr0IEh0O
	 rEgRqlvUjXXLNUru/XSE17I3PiyV9Tzl2FOZZheRtouIzu3EdyJYM5E0WopD+Iut+/
	 XdCnEKGYG5ep5o2/dZVaTzpkfjwSAenLR9B4gJPZJ7lfMkPUpSlXSWTmufskW1sEtD
	 /DFczNa9m7JJ7QAcO8qb7LSws2CyvRxpRQ26n2/jBeldY3270xgxgg9B7etimsb3t5
	 3z+cGOHvSAYng==
Date: Tue, 31 Mar 2026 09:30:39 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Yi-Wei Wang <yiweiw@nvidia.com>
Subject: Re: [PATCH v4 4/7] pwm: tegra: Parametrize enable register offset
Message-ID: <act4GHBpN8S9GH79@orome>
References: <20260331-t264-pwm-v4-0-c041659677cf@nvidia.com>
 <20260331-t264-pwm-v4-4-c041659677cf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="endcprnnhjlzoua2"
Content-Disposition: inline
In-Reply-To: <20260331-t264-pwm-v4-4-c041659677cf@nvidia.com>


--endcprnnhjlzoua2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 4/7] pwm: tegra: Parametrize enable register offset
MIME-Version: 1.0

On Tue, Mar 31, 2026 at 11:12:16AM +0900, Mikko Perttunen wrote:
> On Tegra264, the PWM enablement bit is not located at the base address
> of the PWM controller. Hence, introduce an enablement offset field in
> the tegra_pwm_soc structure to describe the offset of the register.
>=20
> Co-developed-by: Yi-Wei Wang <yiweiw@nvidia.com>
> Signed-off-by: Yi-Wei Wang <yiweiw@nvidia.com>
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  drivers/pwm/pwm-tegra.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--endcprnnhjlzoua2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmnLeB8ACgkQ3SOs138+
s6HnqBAAuq/a2JQNQcAdvDiLBcsKecCFoNSK70EL4LNdGcSXNjocPTrwdVM5m4Y4
P5EG5MhVv5yawIh3S1Tibi56EEYpSVXigYvVi1tVQuW+eMwireVrEXdB5l5/4pgy
0niwrQLh7pgSNmuE/RudUu2Foy/H9/QGheJJ9yN93IZ49D3n+U7ANuUGinccdLM4
8Mwk2mt4fezYaaXd2Naq1iXFyGgQwgXc5paAkb3S2xxiurOpUnLEy/PScNnC/7cF
FC294XuCaYY9GtU02prezFAc9hGDo6daEWV9gmJzQLPaKF9MYegX8DlOcibFpLHe
CbVlDPV7892lqBROIfQ8XuaNIcyd2L4CwRl1p7vDtByAbwmOvQh58IW3v+iJI0mH
BuDCTYAKv21ZFBQoJTonDCeGrvoz6vgAo6/LMEH0xDMbnnIzlV4j7oIBBkUr70lV
1T2Gmu6K3qs2bDzFivFuAkBkfrt4hI+dct3b2vZPPPzL7xEnMgKru9tYlTyWWY7k
aAJgJ1m2TIE4c5oY2NnnF0AQIeZ/3MqrDfDslqmc2KySbWqCke7a5ShgHJOu4nmy
L3UkbnQR2c5iLrrDesuhV+yxG7VaKkhX05ip3Isd/q2bOEJutdZNwc0ejbEkrh6U
5vZjya1wv1dcfZRB2k3M8uplXqNTeCE8btjg1ilbCNKfvu8Xp7k=
=R1gY
-----END PGP SIGNATURE-----

--endcprnnhjlzoua2--
