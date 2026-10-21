Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598719;
	b=VqjETmiet3suU3ghbPlqVpyqaNl9jkoAyDwvuk39kCCc/PJ0amIq7mG+ZF6XujOcjlRU
	 l6c8dMfvl01iG32dkbGIwo7zxdhm3qWXyd3sO7Lg1xQB0ud9XhsacKvleF04wXAOx85Dl
	 V8580sTYE6i18uC6zVFoYZcqISXcNHjGE+WZ+lop7tEpWIWZQrIDTMfX18B5Bg+RIFt3y
	 XJGl3IxlSO632F+cymfagUr5iEb1FrMHjqb/xZd8jYb+qHA2Vy6uSm+g+ZVZW6f9/IjXV
	 Mta4HKeXSnwd9ewYmyXKc4g5jnW5gV8XdoWieH3YNgrv3p+QdJ+ZdHVjIKd3JLsohjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598719;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=OO/jQ74sz4moznSOIcQuGfT4C5O0ZbLQA+114JVzDVM=;
	b=WtOZb3cjYQS3jBKVKj6LOPrVIj3Ib9OEYQqYK9NLbyklqDy11FKuRH6FzQY9/EGdR+uw
	 93H9vp1F/vwFyaUtZgYJ87SHBzj9WJAAOIWf65kYnwjkesnIrM1x6M8RDtn/GOrWGp0WG
	 qv9OkV0oiIMRwmJNJr7xuMXELCqrgmTfu6HTRhOXHK3MNawDi9CLy4eqE9agPpZW2rmYc
	 QcgTKyoEWZ65KjDEgMOz3dnILwGwqNY6a3wwHytmzymeuTvoNZqwnF4oM5mfruZkLqNTF
	 w0/0rH+DPB362GWaiM05UPNcOb8zPTWeH1tBScBhV302SmcKEzcr5KE1cJqAy4CVpig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kC+JIqff;
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA641606A31B
	for <linux-pwm@vger.kernel.org>; Wed, 21 Oct 2026 16:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA641606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kC+JIqff
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c413dea9ca6so138821366b.2
        for <linux-pwm@vger.kernel.org>; Wed, 21 Oct 2026 09:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792598717; x=1793203517; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OO/jQ74sz4moznSOIcQuGfT4C5O0ZbLQA+114JVzDVM=;
        b=kC+JIqffK4rC46rQzGkmweYrHwrBuORYof+4Q79ymYrFiYUH108zupB7/K+ZHWFvg5
         6xOMEzcIQKk42FqsC9rXViLfn/HI7mrYkiMCwCjy2GLBSIHSe0jlf9ikeluMqB2xJCvf
         wuw08XQMARxGWnTiO3lAYlKBfESmd88wPoPL7a3CpuKi7CYtbUDBE+cz55xyBQx0hlxN
         OHpkYrJGlCPqGb7vqH8696iSHlKSLDP7PRnmkwVILribmC4FvskE5nRy0nKReHoeTeXY
         Ou9d9YdojPlS0rfqT4vfA5lfxBlWF6zjswU8Vkd/PQThdLBkIpim9CpG1Gp0SWIJnh3j
         nwhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792598717; x=1793203517;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OO/jQ74sz4moznSOIcQuGfT4C5O0ZbLQA+114JVzDVM=;
        b=eBBH6p79kuX7CSC1WJPrQ8JHqJtnayCvxuaOc4kWFoJGH47INUUeDaocscY+OJ0zOZ
         UzCLWUokYAZQYKQQaUgGyMCdGNuTBG0J8wPc+9nDioTWfO8icPIBxQoYXBJLopJIWB/I
         cTG66Efzrz0v8lH6vfL2r715KLH/QmZOiYRWwyBVHPo2HdeuNAdIn9ogdUMPYj2vOSIA
         khenNGAdACoZufEPeFyUSrocxsq18jladHIPtVh5nF7mnuQ1JbRpi0Vsjhce8uYD/UFD
         4zC/zzTPc+uFNviS1B+Wjyr3DLD9DgUqUgqlb1mtCgdyYhaE8IhR0oDlkmszDMZX+w2s
         okZQ==
X-Forwarded-Encrypted: i=1; AKwUvBx0Qt75AWEev6BeQxmyK9aJ+qZdSaNs/yNO5tE/6zixv13rlTn3vPiIraWfsBmCwTVGFneSap7mfSc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIiIrWAmvZHK5yYJYCj2PhbMCbyb4XZAMMsdPw59gDPVaj1mTy6
	pHsc6DoTKr0aCfA09duf2JP2LCq9VqSe/81aX8ZcZ79+0wQXGkYHu2ZFvy7hYqdI
X-Gm-Gg: AYBFou3NGuAp7UDYjZwwQTUciaZdPckp/68W5d7Tf6+qHgq3ki88mS2uYJx6VraocF+
	aRCmTIhFHAm2L0byPeDiisqwhtVlAccE/SLL/FXWGzRQpyg1DSx9MPvVeX4kOJGaxQFFll7t2uM
	ihEfPjf1M9nqmLWGp+0+KtEkb1w3YjK0xAxwkJo+dq6pX0N2iWm8kwdiMD/doYbzppPGd3pyHgD
	Omf9WS/M2vbZHNZdS8ml1iicRo6EfF87C3bKanZZuSO3ZXzNndDj5GP3hM+IL19SCqSCKcyMpEO
	+gTHuBUd/tGueWnfm44mYIlg8895qp20ekmhDKMEt+6rPGyj56EBd1xxxY2jHo1g5YGcpQXlVXH
	3blaDwNC2S7eKpmitHD3irbBdQoDwbIfVxLlhfMsscdRjnWhcUZenSJTS+i393H6J00buxWYe0+
	vO62RaFF70RUmXf7YQTMp1u0qq5OxCeP3w8a79+1S+zVu66K4/C39cqYLzSkmlHDw8fJpVSRI8v
	QAKs31SrCLlci3qLiVXJdiFmvYMUWX17UdtajJJNxnZ90RGRqdp9CHqe1ahnBB0+KizhWQ/afxE
	4X4K1ObF7rRJclSTUt3gWUZGSSsCd/kv69/YyxSMQ5vrtlEpRBynAZk=
X-Received: by 2002:a17:907:d08f:b0:c16:4df6:176b with SMTP id a640c23a62f3a-c4679623434mr231451966b.20.1792598716864;
        Wed, 21 Oct 2026 09:05:16 -0700 (PDT)
Received: from ernest.hoecke-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25828c98sm6093433f8f.28.2026.10.21.09.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 09:05:16 -0700 (PDT)
Date: Wed, 21 Oct 2026 18:05:14 +0200
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	"Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>, Frank Li <Frank.li@oss.nxp.com>, 
	Kieran Bingham <kieran.bingham@ideasonboard.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Leonardo Costa <leonardo.costa@toradex.com>, 
	Frieder Schrempf <frieder.schrempf@kontron.de>, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH v3 1/8] of: base: Fix stack overflow in
 of_parse_phandle_with_args_map()
Message-ID: <o4uzbsrfnpm4isk7kh7f6tsccd5qghur7vkjkyumgwrylvu2xl@dbeuv5cuxvxj>
References: <20261020-fw-devlink-nexus-ready-v3-0-fd6f1c17e16d@toradex.com>
 <20261020-fw-devlink-nexus-ready-v3-1-fd6f1c17e16d@toradex.com>
 <20261020155841.59037c99@bootlin.com>
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261020155841.59037c99@bootlin.com>

On Tue, Oct 20, 2026 at 03:58:41PM +0200, Herve Codina wrote:
> Hi Ernest,
> 
> On Tue, 20 Oct 2026 15:00:12 +0200
> Ernest Van Hoecke <ernestvanhoecke@gmail.com> wrote:
> 
> > From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> > 
> > of_parse_phandle_with_args_map() reads the #<stem>-cells property of the
> > provider referenced by the consumer into list_size. It then copies that
> > many cells of the consumer's specifier from out_args->args[] into the
> > on-stack initial_match_array[]. Both arrays hold MAX_PHANDLE_ARGS cells,
> > but list_size is never checked against that limit. A malformed
> > Devicetree with a larger cell count therefore makes the copy read past
> > out_args->args[] and write past initial_match_array[].
> > 
> > The cell count of each provider selected by a <stem>-map entry is
> > already rejected when it exceeds MAX_PHANDLE_ARGS. Apply the same limit
> > to the provider referenced by the consumer.
> > 
> > A plain reference to such a provider, without a map, now also fails.
> > Previously it succeeded with the specifier truncated to MAX_PHANDLE_ARGS
> > cells by __of_parse_phandle_with_args().
> > 
> > Fixes: bd6f2fd5a1d5 ("of: Support parsing phandle argument lists through a nexus node")
> > Suggested-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> > Link: https://lore.kernel.org/all/aq1CSswlo57jZpMH@monoceros/
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> > ---
> > v3: New patch (Uwe)
> > ---
> >  drivers/of/base.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/of/base.c b/drivers/of/base.c
> > index f63a9486b130..5abadab22392 100644
> > --- a/drivers/of/base.c
> > +++ b/drivers/of/base.c
> > @@ -1587,6 +1587,11 @@ int of_parse_phandle_with_args_map(const struct device_node *np,
> >  	if (ret < 0)
> >  		goto put;
> >  
> > +	if (list_size > MAX_PHANDLE_ARGS) {
> > +		ret = -EINVAL;
> > +		goto put;
> > +	}
> > +
> 
> I would be stricter here and avoid the usage of MAX_PHANDLE_ARGS.
> 
> First I would check the arrays size to be sure that they are consistent and
> then check list_size against the array size.
> 
> --- 8< ---
> 	BUILD_BUG_ON(ARRAY_SIZE(initial_match_array) != ARRAY_SIZE(out_args->args))
> 	if (list_size > ARRAY_SIZE(initial_match_array)) {
> 		ret = -EINVAL;
> 		goto put;
> 	}
> --- 8< ---
> 
> IMHO, this is more robust against modification of the 'args' field
> definition in struct of_phandle_args or modification of the MAX_PHANDLE_ARGS
> value which could lead to some inconsistencies.
> 
> Best regards,
> Hervé

Hi Hervé,

That seems reasonable and like a nice way to do it, thanks for the
suggestion. I'll incorporate this into the next version.

Kind regards,
Ernest

