Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC78E7082D;
	Thu,  2 Apr 2026 15:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775144675; cv=none; b=e2iF3OWAkue2b2CfPHJH8eyKsndoDjngIIZwERMHZ8IsoSXHNwJaLUxPxrV19wYxs9HUFf9Cg+h7QKcn/TST0kOU0bTJcmvd1P+UWLViVM0NQ3XM8GMzWq3eqPTR8G7D3ap85yWjxRx+467EawaizAZ/oi9cWVCRmSFd95Qjir0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775144675; c=relaxed/simple;
	bh=azq6rPccAYyL64s6PaPux04RMnp/m4vA3aQmA1PwB+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eyfq/F62S+Y/3CUi2opIydgF7s+lFs7MKP97ByRiDAQCR9A+lVLE3HDfJh7nRRgMpw50mCZzZaisGUoOU4tGttN9cEo129HO7wBEXLHWVT0RJoxZvsuoOJioqY6SUlNyVLTFG71oXq0peiGJaazvn2Kj13TXOFLm/jOI9Oe1fsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qfZF8LlD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qfZF8LlD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3684CC116C6;
	Thu,  2 Apr 2026 15:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775144674;
	bh=azq6rPccAYyL64s6PaPux04RMnp/m4vA3aQmA1PwB+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qfZF8LlDV9jK3dpUo3HHmQlZoKNRx+stidWv4GnjXhJGBbmrYY3rw0ySLBYNCZMX1
	 PK3vbmAAw0shZFe0Nysg1lpOGjYbTXcmRo32x28NpBoTejPSafLosWQ3cjxScnyjAX
	 qGxcoJWePsoAIegg/WqhAHELGu1ZnLwumbMjv/0z7df18+8XXwrekoyUdX8Y2n7wDQ
	 /fzZgh0nECyfcvKTzQh7AWr66CO8byr6J8NmhwXNKiFwVokCePb7Uib7eOaraJsoMT
	 ItqzEOVSDRzqoScDdkRHUacP6+WRHkfKAyXmqq7UdkJW8nrNATWmgzC9/J2++ptHCM
	 hJJIYhXli2x0Q==
Date: Thu, 2 Apr 2026 17:44:32 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Shiji Yang <yangshiji66@outlook.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 0/2] pwm: mediatek: fix mt7628 register offset and clock
 source
Message-ID: <ac6OYRkiDt_OJVcp@monoceros>
References: <OS7PR01MB1360282ADC135931ECCAD9AF6BC74A@OS7PR01MB13602.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nosq6hqdgk23uy6t"
Content-Disposition: inline
In-Reply-To: <OS7PR01MB1360282ADC135931ECCAD9AF6BC74A@OS7PR01MB13602.jpnprd01.prod.outlook.com>


--nosq6hqdgk23uy6t
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 0/2] pwm: mediatek: fix mt7628 register offset and clock
 source
MIME-Version: 1.0

Hello,

On Tue, Feb 24, 2026 at 04:51:00PM +0800, Shiji Yang wrote:
> This patch series fixes support for mt7628.

The series looks reasonable to me. It would be great to get some
feedback from the Mediatek maintainers, though?!

Best regards
Uwe

--nosq6hqdgk23uy6t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnOjt0ACgkQj4D7WH0S
/k7wcQf8DbZttWvtDRcy6Kuni91T0fY9QIk0I7HqCTtpHmiHKQsMxqGuvRQkvyj0
d2jN+Z35x0m678C62gahQj4PQwoAD2TimRMG8l4JakiHG39GugFef1ntXqISIUdR
BX+kx+mplwRhrLjCgsGPnM7EWUvn6cEpVrGis4EmU4nca5bbWeN6ZU6qtrsMDUBf
j7F9ipxoCD1f6bQyBy4pe859OOJcSO9WXyLSE9uHSH+vs+tKWILtRMow8sEcf5QG
MLrpWSMR3r3FhMrfmdNJC+F3xG3yCR7x6zxAxi0ZZ8WdS1VJK9AMMAIxVdwv6RuH
7IEs9OpqV4yZaMawC9f3kVhlRkPuWw==
=MxUZ
-----END PGP SIGNATURE-----

--nosq6hqdgk23uy6t--
