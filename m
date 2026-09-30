Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6493750CF
	for <linux-pwm@vger.kernel.org>; Wed, 30 Sep 2026 17:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790787937; cv=none; b=WdYZCJAst0APjqK4p03uUmPuCB0sXrf4GQTuauU1Ken2/DS5kbQfjKAbbzhwNs01zkHUxb5NfHbAnvC165jLrWdvQwWBdT3liu1KwfsIIE37l4tkNbCPZ8ZQ/CPUeiepsmwduRyU1bY+pRHLw1QUFXcee9qHyDLltBKa4q6OjW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790787937; c=relaxed/simple;
	bh=ZAUUIneOAYnu5HIH9P7hXzk9WJKgXOYtiwGV8misX4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+YAeRb+ex69txgxPoouD6pjoxwEw1fMj0EHLDeKXKAvWCqj5jyQduUHkL0zS3iayyi03tiswxHaUNBp8kVfR34IBSuh0fAz9mS+xliTLmhtpRb2w/WINZpv6DuTjTDdjIh7Z+m5ae5KXuGnzSNks8UdUNq3vYvzcZEPGp4uNaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=ZVWwwLUK; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="ZVWwwLUK"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6c0fce17so30779465e9.1
        for <linux-pwm@vger.kernel.org>; Wed, 30 Sep 2026 10:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790787934; x=1791392734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZAUUIneOAYnu5HIH9P7hXzk9WJKgXOYtiwGV8misX4E=;
        b=ZVWwwLUKySpTSjgnfZr09+nNgZkXpUBysyD+h4aUcIeyP3IuzzFdqzIiTFuTeZdYHN
         RJbJvTCynxmEcSPHFTe1oVTfnEdUcCbPks2AtvOHNivW2bKOVP7a3c93nqcww/hnk7ID
         3P9Y4HRa39NjCe9dKP/S1uzp590EUsV7fQ0wfSzGqEBB+Tis+ZfJLk89w8jFJlt0WyGN
         +r56Ta4Lz+sIj1cXgx7EtA7orsAGqU6hDrmFkUsKZ31YJVaFmo1AkBKOHdw5HOfYiAEc
         AFCMgh4f+Mlx2m1m/qAIiQV5QssJVOSdzYg/nEljpMIR2x4Mk61XYT0YSOlbYNO831xY
         i16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790787934; x=1791392734;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZAUUIneOAYnu5HIH9P7hXzk9WJKgXOYtiwGV8misX4E=;
        b=VulnJSRTh5qARaDtNyMEapskqqLSpsR2393NUeWeYBUDLEJaKFKT2gITcKPtEphUh0
         2Q6BOBlZhT66dIB4enY1gWk3mA5rDc3JXzAwdVtaqc/lNyqCGOnDUmyRgvSMzHI7tvSt
         2y97vtECK2pN0psAbprbFdFJgiDM9RXd014z/1xuEj6KAg0KvuiSrFBvOPHEFpbXLo1M
         0Tr1ygx0ZHs7pV3588yp8i7LIvDsP6Ll+1WPRKOBm9McIjaM5QESE9N2gv9nqi0v3CN4
         Ct+3w4dAdKPTFE251OWkhX3xSMuoMbZhNj6RACQdLF33reU/Vc8qAz6gXIXkj1vgnIxb
         v3QQ==
X-Forwarded-Encrypted: i=1; AKwUvBwZ/6JiEisVv7tsiCLvBYm3eDDVWRJzn9S495Jm+7jkY2aoW53bojepOXlDhlOBFf/hqRJAPMR3/74=@vger.kernel.org
X-Gm-Message-State: AFuF++luBSLqIhNq6K0FNOW5kvnmGDgAV0hYlQ0HYLbLjf3mXXHd9Wx6
	3j2huVtx7ivc/DJhR8HpHB7CgVqSPGiWzkw6MLDzww4wjZpNd/cwQVO4X2BvDC2sHMI=
X-Gm-Gg: AYBFou2XNVlCXR1xIoxmOeiO2PB2SAfvT6LLOLM31j/pjk4vjSh41QMEy+6AnJa8fdT
	lENt8xjX6qjlFuHePW8sOhmqZa/L7T/AfnCjyuC5BiuKPN4zHiSHOkJBfWxBFXrdXSx+80KtW/T
	q8U+kDtvewZUOisYjkgSMCcQouDPGm/Oa+0I6daVg7rsUOJN2YlMozTmrWwkINxxFf6SnuY2860
	ini/tweJ8t4hqQy+RAGg+NbyefLsUn/ZPfYYKZthncWCioust8Hz9maWMinNZ6Xydv8tkjCtbIi
	ZKr2aWiaytBYV9H68bn++wy13XcVYoXmXQotKo5P3perSuL/tLLtVo+Ji0IOkD8a9inLAq1Inl0
	6Cv0eZKD2+X04jjWRm0DYjZ/SHG10FwpzCPudWyFqc18RPBOgoc2D+6Sx+ZmNGPsh2Vo4L43RBA
	GZhrwJtsV1eBM8TyfAq1xw8+UTMqRLC9X3UrAUhGne1CeQ2lLGjYXCKiPUhJFPX2wuzcghgmILT
	k3Np7vrFlsC6PZkTKMD1ow6473g+3W7qtakf9J1vwZdASBXkAabK3xJ7pSLU4c=
X-Received: by 2002:a05:600c:1f87:b0:49d:174e:2a1e with SMTP id 5b1f17b1804b1-4a01afe1e05mr38534285e9.19.1790787933541;
        Wed, 30 Sep 2026 10:05:33 -0700 (PDT)
Received: from localhost (p200300f65f19a904e5d8cd228f56d36d.dip0.t-ipconnect.de. [2003:f6:5f19:a904:e5d8:cd22:8f56:d36d])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4a01ef9b996sm784555e9.1.2026.09.30.10.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 10:05:32 -0700 (PDT)
Date: Wed, 30 Sep 2026 19:05:31 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] pwm: tegra: Check for match_data being NULL
Message-ID: <ar1AKd2_V8FX_3V1@monoceros>
References: <cover.1789741839.git.u.kleine-koenig@baylibre.com>
 <ed943d9be3b785514e0f65a5b8c13a78aba7a090.1789741839.git.u.kleine-koenig@baylibre.com>
 <arD7N6A6ncBNR1Jk@orome>
 <arE-s0zbTUn14aIr@monoceros>
 <arFYGka5NpcgJ8oQ@orome>
 <arI8vXaKTvEJi-Zd@monoceros>
 <arJRPVsReXWfUC_o@orome>
 <arz4S1-q7DXM8y4s@monoceros>
 <ar0JBTAxcXVmTx1b@orome>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nf3fi52ehffm5ni5"
Content-Disposition: inline
In-Reply-To: <ar0JBTAxcXVmTx1b@orome>


--nf3fi52ehffm5ni5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/3] pwm: tegra: Check for match_data being NULL
MIME-Version: 1.0

Hello Thierry,

On Wed, Sep 30, 2026 at 03:14:35PM +0200, Thierry Reding wrote:
> On Wed, Sep 30, 2026 at 01:55:59PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > On Tue, Sep 22, 2026 at 12:06:14PM +0200, Thierry Reding wrote:
> > > I have a prototype patch that I'm going to send out shortly (after
> > > testing that it actually works). The problem ended up being that the
> > > driver_override is a device attribute, so there's no good way to drop=
 it
> > > based on a driver flag.
> >=20
> > Did you see that I sent such a patch already.
> > https://lore.kernel.org/lkml/0f7446324f6a0c8f0153d6532d92a6eeecd6a308.1=
790612298.git.u.kleine-koenig@baylibre.com/ .
> > You were on Cc:, I thought this to be enough to make you aware and
> > didn't mention it in this thread here.
> >=20
> > I hope to not have provoked much duplicate work.
>=20
> Well, from the looks of it you ended up hijacking my earlier attempt
> while it was being discussed. It's customary to ask before you do so,
> specifically in order to avoid duplication of work. Or at least answer
> on the original thread that you plan to take this in a different
> direction so that people know what's going on.

Yeah, sorry about that. On that other thread where we were discussing
taints in context of driver_overrides the topics overlapped, so my idea
was to get all the suggestions into a single place. It seems I failed to
make you notice that in time. Mea culpa.
=20
> Anyway, I was still waiting for any conclusions on the original thread
> and didn't spend any more time revisiting my original series, so no harm
> done.

=F0=9F=98=85

Best regards
Uwe

--nf3fi52ehffm5ni5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmq9QVgACgkQj4D7WH0S
/k7AYQf/R0QuF3d8jygNy6Q74jEavE/+xQpUO/OkuPVWoo1ffUcTPkFbc/w/3aHp
TCHePWOpWTtt30u1KkpoSuYKvmPcjiCyVe307JmudFY77ChzXKLesRpVpcbngqQM
epMp/MpTe2XWC1VDmflVe+vwIcjFMx/R+8h6w76uzfhkrdEhvkG9OqK+ID/Qce6K
A2kyyRf3zFON/Ur5gTne+AEZAmVr4COpSnA9gIKrXqJHTrJ4/QwmQPCLKz0kMmau
SDXy00x8z3X+qls2v8QJmiYrWqqyDGvHa6N+k7twp7cvgtvCTmpj9YqYXxbq7vZd
TWyU+hdrFUQdqMYKX4uEvfgwaGMENg==
=85ej
-----END PGP SIGNATURE-----

--nf3fi52ehffm5ni5--
