Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8B54279FD;
	Tue,  9 Jun 2026 13:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781013044; cv=none; b=jgUONHXt3iap/yOzMMS/IBQpk6U7tf8tJ3gOozANnvYWznjnKQe9LVV4B9Z4udxJbvZDPXf1GH32lJgL3W2bXyfI1r4BfI0k9dL8ME8KzXL68WYM5Bfhm5zxVHaylEim74uSBLOK1hAIvHr6BLrucBFZ9oPyV/ALHAVofw2NBwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781013044; c=relaxed/simple;
	bh=ZC0JEzG9itL2kSSG7Pn2Zc0SKj3e2yz4afPqbxGo48w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uAKXUjpyaDfjyAOy7rcjxQkK3T0MODl9jCzBqTkoR5cD07bBG3HCutoAXpGGo8nzwDxR3kOBw/m806pFhShysOPniGS/1OG84VpCw5G53BW/3f5i0H0oVDRSYmgUrR6xEF9N+YJ9xD7vGQl7QuDvXu1ifIsklOWXhiODlKIKQOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BlqhAAvi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BlqhAAvi"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id BA8E61F00893;
	Tue,  9 Jun 2026 13:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781013043;
	bh=ZC0JEzG9itL2kSSG7Pn2Zc0SKj3e2yz4afPqbxGo48w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BlqhAAviZAPdK7Zxm9Kk3/j7tuUJ8YEQcErcP5hH6OEkCXyvhPn4CKEGE6biFlPfH
	 p3j5m9IRmrQP0lQa8i2FLwrEr/NOOM6zh9eKDWNW0+21HFUjJxkCCoG/tOT8SXk0ob
	 MNQvNbhse2ZqNdG1ww4DI/Z1C1ec/TtESboWwdaDfRc/C5aWC8xUwAjSgibu1hmvi+
	 AZ4NUHu1be+PSoaRI9l4YoK3J7wXOJ5VQTv4J0M3xtJKfaGNUL6TF1nDrJgMSQvri4
	 U6HobwAXhb8+mVVWH5RbDNbJA6e55yQUTryoJ9VF2HZ0yJL64aV9Q8DZgiUH6qMwmD
	 YT8T9h9wtwHwA==
Date: Tue, 9 Jun 2026 15:50:41 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Biju <biju.das.au@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v6 04/11] pwm: rzg2l-gpt: Add missing newlines to
 dev_err_probe() messages
Message-ID: <aigZ62nJDQjD_U04@monoceros>
References: <20260604095647.108654-1-biju.das.jz@bp.renesas.com>
 <20260604095647.108654-5-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rgdiqpb3ss33hvdk"
Content-Disposition: inline
In-Reply-To: <20260604095647.108654-5-biju.das.jz@bp.renesas.com>


--rgdiqpb3ss33hvdk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 04/11] pwm: rzg2l-gpt: Add missing newlines to
 dev_err_probe() messages
MIME-Version: 1.0

Hello,

On Thu, Jun 04, 2026 at 10:56:34AM +0100, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> dev_err_probe() internally calls dev_err() which uses pr_fmt() and
> printk(). Kernel log messages should end with a newline character
> to ensure proper log formatting. Add missing '\n' at the end of
> the error strings in rzg2l_gpt_probe().

While marking patch #1 as Applied in patchwork I spotted this patch. I
applied it also to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

=2E

Best regards
Uwe

--rgdiqpb3ss33hvdk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmooGi0ACgkQj4D7WH0S
/k7W1gf/UWODQJeMksuzbz1WkEfCgCGaI/hA1ebo35WR6k3cET4NJIp8/GCEB0KV
kdir5J7EwVGbM9J9ptl8KXF0OFOzGdYZlltFWGPXyhAnBmK8Z6qJ3FjCJzaXujhD
GqWjgv8bMx6lq/m7aEywgHMzC5TV5ZbFxt67WjXXW9Jb2ppvGJXZLw8A5tK2RKwn
/C0w7dBS3Ct6/DtjHxm3bica1aRS7TeCa27nfj7HcyNscHG8OfHXPP4ZGsBHLAO2
MuMwAlJN3nYR/z8wy3dIXu8ICG9/DCUoEpEipIuaEQxJuG1LCAVcDS1mzAHAPb7C
7T6v8GsTjaQbUNkdkQnQSbvbbXDR3g==
=vtOe
-----END PGP SIGNATURE-----

--rgdiqpb3ss33hvdk--
