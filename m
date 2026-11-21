Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795268121;
	b=B9SD7sEgedSopQVy2IyYiiXMs5L4I3GB+Rer2nN4P3Eor+AOya+EyU1lFK1lahAdBEho
	 DJa7SU2G9JHol68RiRBLtaVIEwyqdM4yRfH+cAU+CnSzqA/hS64qKXQgGUSlMPj9QIZiL
	 3AtgmGr+XFaELs7ux3LUvk5aK/yrrL9jSCcLz2M3B15IUILaD7V64/9iV7SVioP4zGzql
	 DfwsA/xfg9+3xCMBBR9o3mw4S75+GTI5afdFDaHvO3N9fFuKBfS9UjYnx57BT0oDpvYOL
	 KU4qSJYnrubhMUcVFLTYBWg1fxFqdunAALPqkDUvK5geNOy5PmxGnspR2dnvm/dizXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795268121;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=fffPhen65RXvgrHvozLgMLsmu+SDxyuRcwXFiGMhJew=;
	b=pELLtv2NqzzsIk/ENxRB0t9WN+69HtttwgXiHTEiJ0uUH/MLKyrF6J5ubUIg5f5EVO4Y
	 QEwp/BYSfpiJUDsxwaJNbREB/JgUztStLrTav/rdfHW9+Ob5oHiMgzCdswmeHkhGC4iuX
	 InhYPgZ6ZV+FzV0dXYuARnYFLOapK5rWHiBkVpBa4Y6ElC1Pn1aQpb8lJxU53GS1IUfnf
	 oAxMQtFHN9/S1KheVvGDwX+7HdCoiSwxGAkyYFJ+uywHzVzvJyd/Y8W16E8HMNXeOhDT2
	 3kkC8yKuFK/epkdSjgc7NUGovwIzGyhEPNYweEMHtiphd28F2dWYzELg6xMd/TuunLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=nEylbCvu;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715B8606A320;
	Sat, 21 Nov 2026 13:35:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 715B8606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=nEylbCvu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=fffPhen65RXvgrHvozLgMLsmu+SDxyuRcwXFiGMhJew=; b=nEylbCvuQdGWOM/Z5RINWTpd0Q
	ZKohSuNpjwv+qUOH+VwAOX6t1I6AhjQcjdO0UNXQmY4IYWW31T+vGl11olyTl22SSSukG4H/CUqjM
	vh5OthKF5we6rnV+eL1JR9NZSnXcfDXBOHp528Gswn27fALsq2tzDLzZgCT+nscdib5axuNJw85l4
	asYmd0Ze7D5MBfuRwSeBqQAGjsYNyEw7L4l+n5mejjv5Kb+mZvMDyw8rMRMw+Joq0Rm92HXlVddDx
	H8q20B6fQgUdj/NVFy7PMz0kUI0XDJQF3a0j9Etgqapx2yPN1kUzG+Vkqj2Hw4wEeg75Z9u0Zq7AG
	mFvw2B1Q==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>,
 ZhuXiangyu <1194781887@qq.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 ZhuXiangyu <1194781887@qq.com>
Subject: Re: [PATCH 2/2] dt-bindings: pwm: rockchip: add RK3506 and RK3576 PWM
Date: Sat, 21 Nov 2026 14:35:17 +0100
Message-ID: <dcRZnWeuS9WMWkKE52x__A@sntech.de>
In-Reply-To: <tencent_85AFCE164FAAD1CCAB95DC7CD804CA9BB309@qq.com>
References:
 <20261121065936.1125919-1-1194781887@qq.com>
 <tencent_85AFCE164FAAD1CCAB95DC7CD804CA9BB309@qq.com>
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Samstag, 21. November 2026, 07:59:36 Mitteleurop=C3=A4ische Normalzeit s=
chrieb ZhuXiangyu:
> Document the PWM v4 controllers found on RK3506 and RK3576. They use
> the pwm/pclk clocks and may additionally provide the osc and rc
> clocks used by the extended features.
>=20
> Signed-off-by: ZhuXiangyu <1194781887@qq.com>


please check mailing lists, before submitting duplicate work.
There is already a better (yet unfinished implementation pending,
that also incorporates the counter input).

Especially as this is a new IP block - including a different hardware
structure, this should most likely not live inside the previous binding.

All the process issues, Krzysztof pointed out in another thread still
apply too.


Heiko



