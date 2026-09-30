Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD734ABBCF
	for <linux-pwm@vger.kernel.org>; Wed, 30 Sep 2026 11:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790769365; cv=none; b=nfQPv1vljF8Zj1e2NTbMrFRmC5DWoD51K2qCQkKStMy0wbqi/uLBrhj5A8G/+qzhbP+yQA9W+loSHVQ75C2/tfxs0RBvtk+lbrTvd9Z4FO+oYOGyO0Qlza4632mYyrpUgHmAjLNgbEpb7NyIMpw5ygideio5PQsye1uhWhmdrTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790769365; c=relaxed/simple;
	bh=KG6BiYXVkut6wA2+1armqrbyGN68UP40llVPal0pULM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/MsTk/6K6gF3PifM3soSO4iTMffvWMup9gqSFXwLJRzlYlzq8pcnSOlBQHzo7Eggo/ZUEoEEL88Q5m2qHI8iGo4G49eRhxU99RrkatIFLBYNw9xrEFqTfrkLDXL+AU1buEQ1UPPLbB0FEzE6ZHlay+wIFtWkvh/Od1HNDT4bio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=YIsdJzDW; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="YIsdJzDW"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffe281cb1so26366675e9.1
        for <linux-pwm@vger.kernel.org>; Wed, 30 Sep 2026 04:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790769362; x=1791374162; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nbYCj712E+4XFuBgODpd1EFeTXIJOMr8QdEF2zg7Mms=;
        b=YIsdJzDWFgeofjItZ9rbRNhCqwCcLXd0ZQ3tMu+avXw+hPCROmC3sq6g30VjiDwSsb
         ip6GnnPa7hq3IKx1PcIgYZHAJ+vMs4tP89gyKrigqNveCyQ60iAdlLzSYbidjuYV4/Mr
         wtUwts3g+zwoDH7Yj3RToQO1GBh+jK4eW5zYYU+gkIcKkbRJi+JHTS5Mi+UZbYeXD3C/
         /GQXgxkAUgL8wSXU8PcX/K6eQPQowPNYzvpMZgwhE9ZCXBobwr4TTSXemqFrGbToCecC
         Bo4jsc92S992tBZub9ZkpzryhFn/cahM4uh4qS2Mi5URs4Ot7DGjhjAYK/HSaXhHiKQB
         qzCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790769362; x=1791374162;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nbYCj712E+4XFuBgODpd1EFeTXIJOMr8QdEF2zg7Mms=;
        b=2j69TYCilyfEXn0mjPT7BM3ySsrZusga1xYc1R9J6AjD9o14geWL3nPW87B3ZchRrc
         HUKMUL5ANm1EyhEz8YYXL9Nmf0AuEh8Ru0yBVIp2hkT8TUqpHoER5aKgORhvf5nsSryw
         3VOs9X3QXk8Ol8JjdT7zYuqqQlqQy1QIdwzitJ9YuaS5NvgwJrLgGdM5w8Nsl5u4O9l1
         cRnBcuRUqGSmhDyq6x09D5h6oABVuAn/kqG97VMhlGlA/GM8+X2JAXLkj1pa3++/RMRT
         eCPlh7E4p0GiHZjfdbeDPqIUljK7LH/L7h+qttDRacEX8yaTA7NpcQBSn6gzuFVgk14i
         G43g==
X-Forwarded-Encrypted: i=1; AKwUvBwbOqyBJ3xVJL2GLGqsMyk5G3HGHLQwHnP95pAA8VsFDKv15jDMbF+EadwJE8FOAaLV1kuFUPHB7lU=@vger.kernel.org
X-Gm-Message-State: AFuF++k1AzDuBba2YNC6SXJeNNjgEvTWUWlWwbEXiTC8++n7L25ibHmI
	lDs3iAOCkWnb/vcV/gDHpKSGsUgRPwdod9yF0F+AbKG0XyP3s7u6RJb8ffseXrJaxo739vWQsPV
	3luE7
X-Gm-Gg: AYBFou03nOBch+yfEvNjqK6QcFIqXDKNNchtoNhT8ZO55ohkwTMF8FDboZ6nDSw1iR3
	VpFchE2GcVFtvu3/4H92Dv+DXj7Om+3kcms++Vym2nUU4e+AvX05/GrdNpgLon6MKIbrBJRLHhJ
	qQUeboB7SXBpv20lNw4ehaaJkiT3+vSY5xAXXp2g9HZU7C2GzN7z4f0Rv3ZoY7/A3pcaDXar8FM
	Apm5xphwIo/rUMFk4u+/RKVC3Fw3jzH2VwA3qDIipzXen/L6/JYYS5iNHHVZHPmLkkI4MwECl8J
	DLq1w+0gKfsVPIew++lY1uk80o4LfbY8XjNUWL95LxxZnyiBnLOYaBdbULDx1bShRo1LK8YtQa8
	R6v3cJbml+4Gy3wH2eCYjYtmGpe8cQ3pieHNcw/ZPEUdL4pGEc/VZRw2uNiAlvGAAtfRYJEdaWV
	bF5lfOUb/g/KXQmQm8lJ2cyMaqzD1N6MSabK7TV0ba97IcAQ56NJpYekYQiWKyexSsNk42VtZvw
	qQRqAhJ1wYI6w==
X-Received: by 2002:a05:600c:1d2a:b0:49f:faa3:3ca2 with SMTP id 5b1f17b1804b1-4a01afebf68mr25206575e9.13.1790769361720;
        Wed, 30 Sep 2026 04:56:01 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4a01ca32a44sm6509785e9.0.2026.09.30.04.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 04:56:01 -0700 (PDT)
Date: Wed, 30 Sep 2026 13:55:59 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] pwm: tegra: Check for match_data being NULL
Message-ID: <arz4S1-q7DXM8y4s@monoceros>
References: <cover.1789741839.git.u.kleine-koenig@baylibre.com>
 <ed943d9be3b785514e0f65a5b8c13a78aba7a090.1789741839.git.u.kleine-koenig@baylibre.com>
 <arD7N6A6ncBNR1Jk@orome>
 <arE-s0zbTUn14aIr@monoceros>
 <arFYGka5NpcgJ8oQ@orome>
 <arI8vXaKTvEJi-Zd@monoceros>
 <arJRPVsReXWfUC_o@orome>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6rgnpj74w7f4diji"
Content-Disposition: inline
In-Reply-To: <arJRPVsReXWfUC_o@orome>


--6rgnpj74w7f4diji
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/3] pwm: tegra: Check for match_data being NULL
MIME-Version: 1.0

On Tue, Sep 22, 2026 at 12:06:14PM +0200, Thierry Reding wrote:
> On Tue, Sep 22, 2026 at 10:33:16AM +0200, Uwe Kleine-K=F6nig wrote:
> > Hello,
> >=20
> > On Mon, Sep 21, 2026 at 06:24:39PM +0200, Thierry Reding wrote:
> > > You're probably not wrong about opt-in being the more natural choice,
> > > but looking at commit 3d713e0e382e ("driver core: platform: add device
> > > binding path 'driver_override'"), the intended use-cases are very
> > > generic, so it would probably lead to a continuous stream of patches
> > > needing to be added whenever a new device wants to be supported with
> > > vfio or something.
> >=20
> > thinking a bit more about that: The use-case presented in that commit is
> > about
> >=20
> > 	echo vfio-platform > /sys/bus/platform/devices/fff51000.ethernet/drive=
r_override
> >=20
> > . If we had an opt-in mechanism on the driver side, it would only be
> > vfio* that would need it, wouldn't it? That sounds handleable.
>=20
> I have a prototype patch that I'm going to send out shortly (after
> testing that it actually works). The problem ended up being that the
> driver_override is a device attribute, so there's no good way to drop it
> based on a driver flag.

Did you see that I sent such a patch already.
https://lore.kernel.org/lkml/0f7446324f6a0c8f0153d6532d92a6eeecd6a308.17906=
12298.git.u.kleine-koenig@baylibre.com/ .
You were on Cc:, I thought this to be enough to make you aware and
didn't mention it in this thread here.

I hope to not have provoked much duplicate work.

Best regards
Uwe

--6rgnpj74w7f4diji
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmq8+MMACgkQj4D7WH0S
/k4RvAgAqd9FufsIM+X10LNPW2vXz8iS437cIitZBmuW1Vk5daH2a6nX3ITro9Xd
m1uBy04vTBPMSXsUwvol6f9Y1h5JW0iYXF2YwTTAlWR3fetaR884qBLR/X6yveCc
Z71fEjfhgB65RixvyS2lccOO5HZMIuSUg78ugSEU/oZmfI1rY27I9D/H21bJtZpY
CUtunPcw+aRBmHe1IY9wTsT58JaACjvTaMyXJnppHSx8Q6Z7ZrYatU3AomaKIemk
ReTaT9id7o5dVHf7gP1rZowooxWdUyjGpXfQ6B3sRPR7SzweCGbW9d8KGcEcSAB7
k3PLVpRXQlv8VzgsQaqq/nbFY0ILdQ==
=3GXt
-----END PGP SIGNATURE-----

--6rgnpj74w7f4diji--
