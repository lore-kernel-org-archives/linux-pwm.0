Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793198637;
	b=TwRyY99KvrbyyCTbTwVxUJter2xJVBOBLyClNCTqbsFbWz4NIpdJGseJbT1jCSqTfE5X
	 mpMzxqPuGJjYE6lHrjBLAnOAzmQIUdALFuFL/aREJ55k7sXjieOsdXxrWYJXKbUb8nXWG
	 KvtDe/5EAb48lWIH7VFoj3noaMhWTP1ZdwFbN4JEyQrUiagqu7iErnmP0b41xJxbGquCL
	 v++GEka4zLC05BA4MkN0FCgaOjjaiHQP1lBPWhrZNgMtyct2lpRPrEzcR8lsnehiofWKY
	 bWKAEe88EIbp4SMN8OksYl36rsW7KlQcO+wUCpXckyXt5VHwKCDPOQe53fTDaSCid8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793198637;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=gvbpjObWezyuObEIw7vWCioNUAtttLKw08sbbnbJ9pw=;
	b=o9urrbOouv540004w0jdo6HMW5s8zWo3a0YA+Kqv+BtKtBOxjycEbgsoAQVNSI+d7e5c
	 cOOWZyatr7Qv471CVEpPPSOdLpjs4ccIUTEeJg2lVw4BMKq/CyL1tcmqT6HF9q+yY85Fq
	 hFiXrusd8XWprP74oVJ/aEO5vnsBVpivwLzaoXptH5XHZ64aMasZvYvugnbChE6oBXAP6
	 PgB7/N0Od9volyGDwPXpcxe5yHtU6shLRMq+bM4Et6TjUpr3/fi7cBr+7P1IlCJ7q68RI
	 pAnSlbX0ErFUI8q2iI9pgiL3QzjPHsDqd5HCiPr0i/S15QGq7Ug9Biwp7MbekEJ0wWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.217.50
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6447606A31C
	for <linux-pwm@vger.kernel.org>; Wed, 28 Oct 2026 14:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6447606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-7cc91ddf447so391845137.2
        for <linux-pwm@vger.kernel.org>; Wed, 28 Oct 2026 07:43:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793198635; x=1793803435;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gvbpjObWezyuObEIw7vWCioNUAtttLKw08sbbnbJ9pw=;
        b=SvEVMLBsmPMey1mKhnfX8eZUf9bJj5JPPY29A8Vk6lgtaJMgBi/OkWrftHDzEoVZCg
         TpXH5NIfk2KizMg3WMgNTgNKoMAGSqWxqx54AxTOSudHfPgi+1oczc8y0qJnyXwOFM1X
         Eas3XGEhoKZ26NWTAiIi801D1AKjxxcIpBtn7fFrBVEOQxz6bWCOufIfrZ8V4G7hR2mB
         emxZP8OGFRVHOEAPJ2j682ny917MbAEHLI88CdmUdrE66rGPK6ihfYOBm+6XHroNxv+d
         AlSJgUZq9NvJXdBD/xjTIk41EirROAML0i7xBV90Q5/WZK25yM7v7PEkgoUICJinilan
         ah1A==
X-Forwarded-Encrypted: i=1; AKwUvBy5gMU5QZtsmYvgXV5PcWZZUQu2gaf+RlGwwGxTcWJYFpdDyECQya/kMbpuUhZz17gDr0l/9SNG6bE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKkH4Q10j7ST9sNfNbARv0tG2G4LgtBmlUdceRwbDM0dQ6SBtSJ
	cM9RPqMqa03yWBrfpoxSqzfn2XR/8Ppk46Ifm5hI1xZDFkhklsuIgOwBIdkEjUCI
X-Gm-Gg: AYBFou01rrS6fm8hizqOscSD8TbfrJpamSBOscwB7EhB41GtF7DQSUBHa9MDeMRaiaq
	9XN3NZITC+Ra2C3cN/p5ow0nqrCWNOXqcB5oLSWsaUfwLo7SGOjhOUjNErR5WbjxtC/UNGnYqBm
	Ai/9jsPE5fBahbEj8FAdgw8F3HqrmW5p661cLqd6xfUAe2GERaRSUFFt8fXmJXRqJPoI5+Hcqkc
	OEvyPfO3kuT/APEWkruJQ/jbNvzhAyyf99pqhiiy7XwISRf3bxNQf6yc6lvHK9iY3mOdHBWPn/b
	eqayKFtmaUdGB8qbcsj7fT76pT4gzTK4FLOR0vCECWDK9TqC/HGemVd4YRAQaKJVA2CormgkFGv
	jMgLYGq1WXEtE7Mk1RUscI7UJVtPgvJ4KVFTs7kW37e3sJb6rbQcoWWUedpyvO5n8Ga9Mvo8XhM
	6KzPIcQxj6GQ/bQ/L0KuuWDBn0QKQuCJnDamzj1gRIyyvoPMzICpVFzXfoGAhzu6qQ2HBPMrbdB
	w90snLdvTcqgKSV+MU9+rqQLXs0nPQK0OJfvZGfSHTHoCCkQlIi7P08ElQ/8gIjTc+73KzIWVkL
	+n0dJIXrdUn/g1Xf5lrM1kZtqvzgZpBLStVEIH0mszLq5lN50ihZgOzV1wZiKTWKBak=
X-Received: by 2002:a05:6102:2b9c:b0:7c3:8150:83e7 with SMTP id ada2fe7eead31-7d03a50a337mr961474137.9.1793198635570;
        Wed, 28 Oct 2026 07:43:55 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99125a07478sm6189825241.12.2026.10.28.07.43.53
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 07:43:54 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-7c03744ef27so315583137.1
        for <linux-pwm@vger.kernel.org>; Wed, 28 Oct 2026 07:43:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByiwhunxGeECLC3JtlGpWgO2oGKvBP7hr2C1qmo9M+fgvTwBn8AeOiWHnz+WzgSOSVJhOUcaUmvHgs=@vger.kernel.org
X-Received: by 2002:a05:6102:6f07:b0:7c3:1d7:f234 with SMTP id
 ada2fe7eead31-7d03a294a6dmr903761137.2.1793198633657; Wed, 28 Oct 2026
 07:43:53 -0700 (PDT)
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793026273.git.geert+renesas@glider.be> <e723696e02cfb34fb808e2ae3ccb6faf68528c00.1793026273.git.geert+renesas@glider.be>
 <20261028132937.GL15441@killaraus.ideasonboard.com>
In-Reply-To: <20261028132937.GL15441@killaraus.ideasonboard.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 28 Oct 2026 15:43:42 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXycpJ6COtiAA-2oRRfHSfLK40n2cacStW15QJRN3EfLQ@mail.gmail.com>
X-Gm-Features: AclHuK8gWV6NxtQKAEUrEm-e_rgKbr7fNh5k6QXPge3G8NVSao5SAOErcvAPoSI
Message-ID: <CAMuHMdXycpJ6COtiAA-2oRRfHSfLK40n2cacStW15QJRN3EfLQ@mail.gmail.com>
Subject: Re: [PATCH 07/11] dt-bindings: clock: renesas,r8a78000-cpg: Add PWM clocks
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Ulf Hansson <ulfh@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Laurent,

On Wed, 28 Oct 2026 at 14:29, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Mon, Oct 26, 2026 at 03:55:23PM +0100, Geert Uytterhoeven wrote:
> > Add definitions for the clocks used by the PWM modules on R-Car X5H:
> >  - R8A78000_CPG_SGASYNCD16_PERW_MAIN,
> >  - R8A78000_CPG_S0ASYNCD8_PERW_MAIN.
> > Include R8A78000_CPG_SGASYNCD8_PERW_MAIN for ordering consistency.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > --- a/include/dt-bindings/clock/renesas,r8a78000-cpg.h
> > +++ b/include/dt-bindings/clock/renesas,r8a78000-cpg.h
> > @@ -28,5 +28,8 @@
> >  #define R8A78000_CPG_SGD8_PERW_BUS           18
> >  #define R8A78000_CPG_SGD32_PERW_BUS          19
> >  #define R8A78000_CPG_S0D24_HSCN_OTHER                20
> > +#define R8A78000_CPG_SGASYNCD8_PERW_MAIN     21
> > +#define R8A78000_CPG_SGASYNCD16_PERW_MAIN    22
>
> Could you also add R8A78000_CPG_SGASYNCD4_PERW_MAIN and
> R8A78000_CPG_SGASYNCD32_PERW_MAIN for ordering consistency ? The
> dependency patch should then also include R8A78000_CPG_SGD4_PERW_BUS and
> R8A78000_CPG_SGD16_PERW_BUS, as well as
> R8A78000_CPG_S0D{1,2,4,8,12,16}_HSCN_OTHER.

I could add them, but do you have any need to refer to them from DT?
So far I only added clocks that are listed as clock supplies of on-SoC
modules, e.g. R8A78000_CPG_SGASYNCD8_PERW_MAIN is supplied to the
Timer Unit (TMU)).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
