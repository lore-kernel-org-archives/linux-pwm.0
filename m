Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CC52F39C7
	for <linux-pwm@vger.kernel.org>; Mon, 10 Aug 2026 08:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786351404; cv=pass; b=Kgtxwn3Cl9e/2yE3aJlLVpQBFO0Bs1Kwi/Z65FI+OHixsm81OGI22mDLWT5MoK2sVU8d3Tlabf3flt242fvZLfTrayEW77PCc/ph+L/4PdHNBJ1gRSSbQPTc0MyWg10731nBtJ/Cd4aaoa3K/ofTS2WqxkMDcn6FVBghfF1X7Bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786351404; c=relaxed/simple;
	bh=vsOKCOkyS6rUiXdWk0fb9QExEqjNoSQv6E1PbSa1uqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hv4zVKYgLWdqQ2CyBg3ZtETMvi4kiLpfbz5/j0YV9ddY+5eR8Aq8IweKgBG4L49tDboF4YaVSvyGG6zvbFQeuMDPFvZbezRJ4vv8MBUq2JMjuXYfBbEJqDcxoKlbtVa02fwwpZu8rhOTT5HkFXAY71jO0OkhgIC7IKJVdqJPZcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VcZA2NLs; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcZA2NLs"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a1b51723a9so2583929a12.1
        for <linux-pwm@vger.kernel.org>; Mon, 10 Aug 2026 01:43:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786351401; cv=none;
        d=google.com; s=arc-20260327;
        b=LTO59KPamYAhx2crZpAeqgPD1qsXmz5fdiIPgk6zrIVSxSZY57U3JytcJ3gbmDaPvv
         eT6Mw2gxpyzjYHWdH1/+WJp0drxXQ4eN7pbHHXyZcjHaTEVg/9Y0/rh/eO2Lb75L5NWE
         oOFAG9YAjSnUNGqXgMEYDz/ymoyEq/iFFf4AXJgopDHPmkEtbOr+dupBhLYOHh+KraHH
         1LLR8t8BwskWMHVbrITbEnxknAaVGMooax5VmXqoiuwS9UT/FEk5eMEpvwuQ2Yua/5cZ
         arbu02usfJa3eJZ3Nwqn5Cfpo1xK5nZutzg3n4f0QoVp3rn12wv2a70af/trbv3miKsT
         U6uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ibzUgXOGiUGkOiEFkYb/0y6YpV4m0bbnGovRuTHx8eY=;
        fh=dafc1Q7zDyWg6m4TXyarooFQlsvTlidDjGMyex0bU2s=;
        b=LdEezTGMgrfKY+9VTboB2rwQZeX+hEXQ9WWRbFiaVNO7euJX+j1SroKRu+fARzNgbM
         cstUe55y3njfuRR6NJ3a1eaXJ6aMUB4RnBcb7wI/ZUSJUykziDV5yAxwNuAl7Z3gZXeb
         jYDLkvJ2CUomuGjWyT1O2/QsL8iWVRqM7KNmNT6l98NyuVmWSI2zEKN1d9H+KdNvzElg
         bChO0Sb4i4g/tbN7ou/S2D5xYkkQ1xE8B2DcvVxsdnjWt4hh8UFUiyoBYOHzmqmN1oSc
         y6RiHhyzrLO+3c118uveuh+PLUarkzNVjRbeWBjEhkBFohaUPyC05FLLJM9ydQWLrPeC
         qq7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786351401; x=1786956201; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ibzUgXOGiUGkOiEFkYb/0y6YpV4m0bbnGovRuTHx8eY=;
        b=VcZA2NLsyiTQouAX14A2J65XkRwxoSmQiCLtlwTFSQvrgaTdJ/qylKQLV1y8tSQzJB
         5mehG+oa/T23UNpLGZePUGaMz96VgirE4R1OHKjxKxDqGJtaSeOIrDccCNZQYcO45yhm
         Gz3vVErdhoFXitXE0mx7YMFZ+K9Zuyha4fYnzjGS4c0p48x+chiayHjlNMn3YdHXP2sU
         Ziy14RSA9JhPEoj3EsifZYshIceH/pBJglm709CwyYT0InqhLENt8TroaR7/5lueHJYM
         SK0bhXUkMvOJwHfEv9Tikv5YjUjV+1xNTRKmnmzdD7EZIMFLf4Uo1BcdTF7RSooq8vGw
         4YvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786351401; x=1786956201;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ibzUgXOGiUGkOiEFkYb/0y6YpV4m0bbnGovRuTHx8eY=;
        b=HBfhAt1xauZxhqrHHPfjEyHk2xhiVWXSaocvML53sGeFc13PGtPleyndR2fiNv8qji
         XOpHCSFYQZNgFbPsUd2yW+qW9Rl8xXpTTIBGgq4nK8qUqvZGpMEzWP7yYEg4Br9qoawl
         0I3cdwfsTL8r2YK5S/9f6ervsYOHUf7BOOK69fqdoCley8FsG1bqYl8ge0GKy+2ZIfGc
         Z6GrvQkX+cd/qTU7i77sZ1B7fxxoGjRstov7qfN8Qx7HqhlpkYEzLz5Pr++KJfoGeffv
         vS+6IPm/U33B+ZVtti+Ubm8BAMv/YXzPhuzuCB98sHhUACELZ1aqKD1ozpxpem76VRZd
         2BxA==
X-Forwarded-Encrypted: i=1; AHgh+RrLAduDBtczz2CJp00WKXrj5jKt8zbaFrwoWpwO6AndkwgMHv9SySoBOiK61Hkbv2HzpbbsDllivZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgygAWbYGIr+vyw5kDsQbksNmTemcdFa69m0BXNyD20OEwGIEj
	JuC0fJ/Xeb44ybpyPF0VL3OzcIox109lcB5NX0mLnDbBoSevewPmBZ2D0SFIYTwvAI8jFJSUJs4
	XQ1vNQNLVP8EXhHDQ5Jp2Cy4Crt7je7M=
X-Gm-Gg: AR+sD101oCZZItiAUHmYzshYouwwvx8kvI44XMIcRZ2Y1dhp+jRGBk0SaRb66/R7+1+
	CRQkvyO3VY53lMj8cw0O4lQlvjky6VF0d7Xw5wHrsz1LWBE4ikrK2KDLJ/MunP0ji6lTAFf+6Zt
	LF7l88V9sEB6aJU6i5px+GVnVxkw5aMVjoKOqc1sXoSBhd5i4bF2kw7ymP92Odl/x4EAb4YguDH
	oB+FubXFi10I/0k4zP2FvOBiOldDAW6THkQfbw4qlJJw/S6gTnnKZlsur4/udBYANg/VUYgqHLz
	6mNvy2MI+K+da2JGXUVZBtxpT1rbiPvQiMwKU7TL0uxj9GnjNjefU9GIdvI=
X-Received: by 2002:a05:6402:a0cf:b0:6a0:a4f5:f4eb with SMTP id
 4fb4d7f45d1cf-6a355d66d8bmr212253a12.4.1786351401282; Mon, 10 Aug 2026
 01:43:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604095647.108654-3-biju.das.jz@bp.renesas.com>
 <20260604100619.75EC51F00893@smtp.kernel.org> <aliM3iVA1LY7tW38@monoceros>
In-Reply-To: <aliM3iVA1LY7tW38@monoceros>
From: Biju Das <biju.das.au@gmail.com>
Date: Mon, 10 Aug 2026 09:43:09 +0100
X-Gm-Features: AUfX_mxbp2F6C1EJALTGqqu13oGNxfjr3ICGyNcoGi9RkqGNZfVYjkhbDxxzl_o
Message-ID: <CADT+UeB-gV8QnuwpTUrHV-GvYPwebYg=RE68PcApZkACO4ENDw@mail.gmail.com>
Subject: Re: [PATCH v6 02/11] dt-bindings: pwm: rzg2l-gpt: Document
 renesas,poegs property
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: sashiko-reviews@lists.linux.dev, robh@kernel.org, 
	wsa+renesas@sang-engineering.com, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Uwe,

I have clarified the use case with Rob on [1], and he acked on [2] .
See the details below

[1] https://lore.kernel.org/all/OS0PR01MB5922756F1836AAABFF62C04786049@OS0P=
R01MB5922.jpnprd01.prod.outlook.com/
[2] https://lore.kernel.org/all/20221215205843.4074504-3-biju.das.jz@bp.ren=
esas.com/

Cheers,
Biju

On Thu, Jul 16, 2026 at 8:50=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> Hello Rob,
>
> On Thu, Jun 04, 2026 at 10:06:19AM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> > - [Medium] The `renesas,poegs` property improperly encodes the consumer=
's channel index as a phandle specifier, which is a Devicetree anti-pattern=
 and breaks standard phandle-array parsing semantics.
> > --
> >
> > commit 9d7f9847d3f320fb715022b6159c9c7e869aeedd
> > Author: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > dt-bindings: pwm: rzg2l-gpt: Document renesas,poegs property
> >
> > RZ/G2L GPT IP supports output pin disable function by dead time
> > error and detecting short-circuits between output pins.
> > Add documentation for the optional property renesas,poegs to
> > link a pair of GPT IOs with POEG.
> >
> > > diff --git a/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.=
yaml b/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
> > > --- a/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
> > > +++ b/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
> >
> > [ ... ]
> >
> > > @@ -245,6 +245,28 @@ properties:
> > >    resets:
> > >      maxItems: 1
> > >
> > > +  renesas,poegs:
> > > +    minItems: 1
> > > +    maxItems: 8
> > > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > > +    items:
> > > +      items:
> > > +        - description: phandle to POEG instance that serves the outp=
ut disable
> > > +        - enum: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
> > > +          description: |
> > > +            An index identifying pair of GPT channels.
> >
> > [Severity: Medium]
> > Does this property correctly follow standard Devicetree phandle semanti=
cs?
> >
> > By Devicetree specification, phandle arguments in a phandle-array are
> > defined and interpreted by the target provider node, with their length
> > dictated by a cell-count property on the provider.
> >
> > This definition appears to invert that model by using the specifier to =
encode
> > the consumer's (GPT) own channel index rather than a provider argument.
> >
> > Additionally, standard OS-agnostic DT parsers might fail to resolve thi=
s
> > because the referenced provider binding (renesas,rzg2l-poeg.yaml) enfor=
ces
> > additionalProperties: false and natively lacks a #poeg-cells property t=
o
> > dictate the specifier length.
> >
> > Is it possible to redesign this binding so it doesn't encode the consum=
er's
> > index into the provider's phandle argument, or at least ensure the POEG
> > provider specifies a #poeg-cells property?
>
> You acked the patch. Is that review concern by Sashiko valid?
>
> Best regards
> Uwe
