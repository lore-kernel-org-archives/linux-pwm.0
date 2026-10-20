Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792460248;
	b=aCvlGA5JDsd8FCFnt4IUPcvBCGrSD6Nwr9L/sH2WdnO/1WLrtekSPvKoyf72WVfzArbO
	 j9rJ6HqxWQ62AQQaZKxETAQzOBl08TmSpoYEitr3o1aePv5OAkXd3F2//ys8lnlq7bRWw
	 7GlQkGaVEDDAzbf5Eq9h3a3C/nEGajVaiNRDYqrthcp2uX/ubvk+8IWQz9cLDmNvagiRr
	 zdrGM+pzLWI0JaCBV/zthcLW3TEOGHhFTnaZaU/A4reTRwsBKbckP1Qk/ZnnJegFkx1aA
	 YUycCX9n/8L1jx1XHZnpyP+nDWiY6Et2ivGk9T+SrnFdiNbiOARdP/QkKx5weBf3b5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792460248;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=TcJGBZQnqhTqIvez5VyLtXAFQZOBgnnr6VaSTFruo8k=;
	b=RFs2wyn8kvQ1vRvRhFZUoFwgk8QLXaqRGvIHylyB0RSgQjFGwUzeNQ2/MvCyh0fA00nc
	 cAukFqUBM/fb8DcLK7C4JDsS3NXFfC/lkb5GAjDcpronY+BpEDelb6E3/Zlrf/+iVokKm
	 EjruRGrwRc6D6GP4tmNUJy84goFLPihAXjp/5mg+mdh2foI+I/DK8ib4IaVbMOEUWd1A/
	 qZZWYFhj5YUdFeg7g2fUboawFm8zMuzzVw8NCkhdoYSwML3aW3nGE3jVjjGx+ty108pzv
	 HxCZsUp2QaFmJ7fYfPkQBYCO4c+w60ckg6JeeacTP3nP0iyi/iflNrxI3+xLjqCdY1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ecmXx3NR;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FE0606A31F
	for <linux-pwm@vger.kernel.org>; Tue, 20 Oct 2026 01:37:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04FE0606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ecmXx3NR
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-35f036b17easo1645372eec.1
        for <linux-pwm@vger.kernel.org>; Mon, 19 Oct 2026 18:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792460247; x=1793065047; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TcJGBZQnqhTqIvez5VyLtXAFQZOBgnnr6VaSTFruo8k=;
        b=ecmXx3NRtnKBb0bx3OKSgxIGlOywd+JyxPJp60E/ketB3hMnkmpLkH8L4kcdJeA6Jl
         EMv31nRk4M5/ktlcZJcz0TUpYNZrDTjGmjF1tedEYBM7w+6xPr+Lrn+qPR8G3QZ6JbhG
         NESF27cdh0velfvj+2DrkT1yLnB/vDSgAZOY4mATGCWkyZKYKXVEe9SoJOmfeDb++d4E
         LsU8MtxwGj6M2KGicp3ue91OsgkOef1ZKEnqKl5cto1+sEfHdlu/c4CauXWRFZ7L2FpB
         5HAi4OaYB6E5btRgmlcTXLc2QOcDGhYjgeNwmoMugrTDSGeJXWNPju0Z3o0fQLnWuN15
         jnrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792460247; x=1793065047;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TcJGBZQnqhTqIvez5VyLtXAFQZOBgnnr6VaSTFruo8k=;
        b=AQxWGIu29mLZJKWjbrIf/pke+dqISnbgp6E2Ig0kWBrHuHh+vHKO5Lqk4XMA7TUukr
         59oC/KH/YF3dEpom33427sI5rITZw0YhY/8fxzwEbsrl03bdl2XLIXLsOpsSWZGS+Uri
         SgVtJ+4aNd48OmhhRRLwLP2R67rckrPLHPrzzmlC6byLymgqSA/nkJDYrXKEeVRYxY0a
         fRQjd1wUp05aljixAhlnxdT4AaB9pthmOcHcmiR+5EMtgtLcv7nyVKLIDbxBqqqsDmOx
         nthv9ckp85xC8iBPrk26v1ISjQ/guDuUxko9H7eEv9fHzCs0SzXxHycL4BZWPmNuEWch
         b3ng==
X-Forwarded-Encrypted: i=1; AKwUvBymzF8IoYDuO8YibWsHRby2nmomqZr2hurvIaTfDxA1WAWfGldyLQWsdFJ/5DlLw2nopyOh1vOlWLc=@vger.kernel.org
X-Gm-Message-State: AFq9FYI9w74F+d7mtQzVuxLXeEmfoSZ+e2T+5NMNn31SaxwsUMsJ8Dt0
	BLnG/TapGPG6XV49yLgJnGf0JeEmKl95+AiJ7AOZpwiiV3C6w82ZTvE0
X-Gm-Gg: AYBFou1jiEUbQaCcJAqy9YkJefOmZvpdaP9WVgfpBnzgUd+f9lJGBSuXaNuQsaun7uv
	lsLpg4/TOElKwea4iJXJBwPDGYm+HH4s5qBX2U9mTrHbT0Vk5ai37MRmjDCWdNcuUPny4Nzuz9U
	oAYYha3CnB9YxqAaYaDzWOaU8+e9pAA97Pz8D51cXa11I/SggdGVvIe6rsdGmTg6BFLozWFq2AR
	NetrKwaAAZz4EUbN7KgdIoWipHmtSAWOL/JzKkopgU2dEl9uKlV4l7hYflD+wcBHx7JLy5EhUxE
	zo5Orrm8XKjYt0jHP1nOhof/T69u19OvkpupaiyVjSGWkwhQoJOqV07koXd1f9RhZcdAIRNzCjh
	CRWREjs95FQ70Fz9h0e0Li7bS7ESaG6gW3eKRTBZMmAnM7DTaVDFSU1SsGV02NCjHTZrY5O6+Od
	a1K16W5IhTOQPwG4sgfUPQbXrKzJ/f4xa9Zn7VD9tSqcis85AtsorspS0PHK4TWjA/SOzjmkRNU
	O1G+B4+cZCB
X-Received: by 2002:a05:7022:120a:b0:171:a066:938e with SMTP id a92af1059eb24-18512c384b3mr12193156c88.21.1792460246891;
        Mon, 19 Oct 2026 18:37:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1830f213ba7sm37626819c88.0.2026.10.19.18.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 18:37:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 19 Oct 2026 18:37:25 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Yureka Lilian <yureka@cyberchaos.dev>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hector Martin <marcan@marcan.st>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Sasha Finkelstein <k@chaosmail.tech>,
	Linus Walleij <linusw@kernel.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	Andi Shyti <andi.shyti@kernel.org>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v2 01/10] dt-bindings: watchdog: apple,wdt: Add t6041
 compatible
Message-ID: <1a720dcf-9f67-423d-b998-d0db73f82899@roeck-us.net>
References: <20261014-apple-m4-pro-max-initial-devicetrees-v2-0-961edd8d661b@cyberchaos.dev>
 <20261014-apple-m4-pro-max-initial-devicetrees-v2-1-961edd8d661b@cyberchaos.dev>
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014-apple-m4-pro-max-initial-devicetrees-v2-1-961edd8d661b@cyberchaos.dev>

On Wed, Oct 14, 2026 at 08:56:08AM +0200, Yureka Lilian wrote:
> The watchdog on the Apple t604x (M4 Pro/Max) SoCs is compatible with the
> M1-M4 SoCs. Add "apple,t6041-wdt" as SoC specific compatible.
> 
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Applied.

Thanks,
Guenter
