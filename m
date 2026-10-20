Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.6.134.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792509218;
	b=octa1/q7MQeKRTk0OfFN87z896a8b0C+eGOSH90FbpYRgB0bboPj6qkAupuSCShqqM+p
	 4WMNCpGCO2mwoi2VPJoXUbpgVPIS1hNUCuI4r8H1/m/e9B5BFTe0sHRDDS2k+VaG6JDu8
	 CVshwzvgWhDFLWnRfOkFqAKFjr5iFBAm8svgEeQw4tgYJSwhztOo9uHzcN2qzjsX94GXd
	 pCHlorj8vRZ/XdtZ0Ughqa83Lel4ETjN+UdvgiE74pyvE3jqe9cZaH0xiR2bSkFc7GiMK
	 Njr3ANyXY++NoATKh7W7DH6NAPFuC7yi3gvVEZP9XCUqzn2qDsiGcqouulAf4AeCTVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792509218;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=gW7rrrhTvNhaJ7ABkNTgkXkWHwGvVO8uazQn6vOaTgU=;
	b=OHQnR76xr3JcjL8oUCdyaeCLLosau6Gmr4HxZax13fMVdyUWdGJZHQVbmpdCKnSQhB05
	 A+0ZDnSQ/sH8E2F5Ci/g6tdatJ3DSoXSE1XUbwfBtsa/JryAbGb0hsgsiAAFMghuZQSCm
	 Km084CGylG2LjnNqecZfVYBNxComi0LusVKgI/50w7PpMP6ufZmQpIfpaX7UbVRlF1wiH
	 dElStiEi6k1QjepISchmDP2k0RP3tMVinAFD/Y8N+R99eNykbC7IVyBRi5WMlq3qVthqA
	 jqAWtoH0+w4etf2E/XlNX+jEHPnOnqgTGwaUYgt6buEEbvE/Efp+8RVUEeY4dPt2K+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=Zg2jwCsp;
	arc=none smtp.remote-ip=74.6.134.41
Received: from sonic307-2.consmr.mail.bf2.yahoo.com (sonic307-2.consmr.mail.bf2.yahoo.com [74.6.134.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0769F60A262A
	for <linux-pwm@vger.kernel.org>; Tue, 20 Oct 2026 15:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0769F60A262A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=Zg2jwCsp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1792509217; bh=gW7rrrhTvNhaJ7ABkNTgkXkWHwGvVO8uazQn6vOaTgU=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Zg2jwCsp3P4iMf6pRdIUeLBSunTiSsyewr0xl+jmQAnHdf/piFw174yUvzoRExzOFK+i4/f6bUtWVgKgc7oGbFdQBCFJq7rxoa2WobQmoVRwEL53hHj2PxSbV7p/xfm/1xGkjxI8Qcpc0MdV4Z7IQTAkgTuxPCkJLS0bAC5X1P7fGRJVjTWP1Ta/5wjgoalO8l0cJPk8+Cc4Ug4LpCIm+ZTfO0gERO4MaXmQgsi3ymsGYli/iASTIQlP+/txsAuw5O7axIQQr6n0kGBB3Eqbx7n+pI+bWby2c9SwlR42RqXVYfVVirgf+19EPCOjWSTGChKtr84tvGtWpoTNi/CoLQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1792509217; bh=gmW+bm26geerfJCjP9YQbjYnU5IJ4Zl4rDpAZaWUBKV=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=jnM2lNgJTnGWuKgQrtlNTcRKAYpKff0QTk5gJ9nlofuddaYs6U25QyNv+2SYyci4MLEOtqmAmYmIgnCrFJLbyxgEaTn8VvVVJ8V5DuJNXVsmSJIRF9ZIEge3S7t0FRUOE96UuvuzJIA1lqV+cfjgPpsnWsscXQoQ6v6bsY9E/ZRuNZZ5epy/l6QLYsV6FyjaMueibfBhCwY2oEXQddT987cmqSc4cKE05TKeYbbLSzd1Q1NnOUdATpml5rOy7rAf21zF38XNKid6r4nbbq2s3ql7IxM7h390va2FN3dioTWEn3K7GrH7IuGuiNTvSYp4qqTLYZ0rgxQohyFP9VeNLg==
X-YMail-OSG: jCdKiA4VM1m7zt4OsFSXXgI_fAwkzi5Zm5csGs4LKuPiAa01PuRLbKdHG_Webvs
 j2CosCrrbIcRxC5XmAys1VOYgDiUQ24TBm2.rDg3FRmivj8U1cKWwdMseRzOOT7rEgZXwutuu9Kv
 y57cciW9USvDkiPX2uIFFpEI7XZ9EY.uoo50Ykmq0PklddEkV70f44_qLEwOACwhE.uWvRccuRPh
 q_9KKlGvOcV_7gyLim5eXA36w_FDNQAfcpsnNgEbthL8.pmlAOWdt9eWkAbh4Ac0dLmawscnwzAi
 wFQpMUAW9uRLjHDx6uiMdWdvttV169PFa01A42VBwmLUuMpRLPLvMNQVUgfugAA2iw0877JkxSae
 h2KW8BmwruY6jBF2ORvlTOhwFMm7.QyVNqSRyXDAJQho9xT2lTPcnZ_SBw5QucqSqxX_Dl0e4wBa
 yhm0ezh.DCt6MWEcAHTxwcQLShTTC7ImR6fzwqwpYE6fnp5l5tMdUhll.6Lwxaa9aLvy7P8bGWX6
 cKmjhG0w493LIRe7I7OZJEElN6WFvaLO0xxPVAPFcNaFCJUsK2Z_bINKpe6LsJq7_m5nXfxLz3nD
 0zIaeOhJ6JFOulsnXb2NXV8onDLl4LjIgXbbHPjtd.W_WsSwH4oCqgLmoWabhceLXJ5EvGvzZ.jf
 W7MLyOAT2w2a6naK2DYP0h2purBRJJiweaKJuOKkPYLjq9GQnKja2D3rEPLGmTMvG1tmdfAlbRRe
 SERUsUIg5EncnbetEEKcvuy4PuTexNE7TWXXym6.2t_QOrs3y4Ngvi5MPgAonNIK8PMvKjJJ1Pk1
 7.ylkOLoBT15HnezKrbK6mcI4aZ3Kbb4N8HKNm1ELJnwp5.W_gnaWqCxuUDiNVN4du2tHg2w7tnO
 A66sY82iIGHG2wttqCV0EACsopUL2sJkRq_N3CSfM8jzzdq9YFPDwlx7chwvhEPri46SPQG95lk_
 TkHgcu2kNWch7EMi3_Z2L4tnAl0R01l509D2PzyM1YKvmY_SMoZQ0m7fHao.jbr0CV8ke8_SsVUc
 E_d.4Lh8r9srRrx0j3khLLfCOLZ3DVqZUPL7l.lggzNtpyA67IDkOlr8nNF58l5mtpBud9i681px
 U5Pp8p.dexvPAGhjbQ0fhXCYSUExBmNubDMP363WFz3Q8rjR9gE8lTbrja3Q2PfeRaTXEM2c9Bnn
 XnYUwrP_2U8x.jt2g_lbfDez.H5KsS5fVuwM5XBSujsl0AlUQeceHtdk4c_i_wyJxFZSBce.jxGP
 n1SAw68CK49JwUq0yw7_CLK3aLk4ul7DhIINnNRhHxb64Ki1VQsgDX5Hnz2WoqXRzB2I5iUNlJTO
 eGoOSDk6ogmDPP2.p.t9Q1YLel3UOmD3y2n691jeINSlnkZ56nD4LOHaiaBGACAMXlCPYPn7BfCf
 4bQ8d2Merjk4X67Jgn9rg3e1_R3g.98EqskjY010vmEeGBJIL5y4pgFsJkeHHW10DZzmDGMcnRhB
 OuUHcm7ZQZ7Twtf2uKQhe0cSWuw13d_DoPN0SrYtatam61XRsDp7ShW6DZ3VKQC4fo0Xs_ZcGmE2
 O4QRLgPfcUSynoZg0NUj0xy0NgHzyUIjo5onPbidnygCnKXSmKI5v7znzX5PduFBl9PDd_8l1WO_
 YHJg8.pfjoIsClik8GKgWO1ZZf_n39k9Q0fgFbTZbvjb4pgjqN6rfM_OXCZ8yAJptI7kWs3kqJPK
 gk7NMUuNvdQXD.ENewdEvCflU9WxkNzJ.hRS7Kcz7Po3XlVeqQMIGJ2OAQ2BLyxBZN8vllNEpvY_
 lUXsESPI.aB18Gtov.FrY_HyLPfARXQe.5iIFprw2Y.per9BTzDiuinhu80p1iue5CXood2C0XPI
 jldgJLzcc7aGBkhhQAHGOmKSC8Ymu9nsV3bLgdWPM.uih_76SAmkSsvLWQdUjCmAdLdrEh3vdawh
 sddnTdgmkFC8DQ5d1utVDD4leOhREQ7l6fFNpf7TS90zfRUh.q02RSnDl.rJMGvl2mRXJ0HXPNsi
 jeKDbS4mbT_KB.C3bXJW_6JS4gJ0DHtTS8lFOfB2vw6e0AcZ8iwFcXp.zqjFu_54MusaKN5MtYyK
 EXT9LTXsPWHzfctZp_.aKOxiNKMU6tvrRfE.kc2bGD7cbthqjH373fxgHfSvtLrZfZ8ipmFKFQoD
 cV2cnfasJiDG4tg8vkAcYdyNH40myIYfYDjV.4FLngWbKgNbLW2a2HRl5brAqE3ZhaQP9u7KmR6m
 ZZTqPOXRTew52tJsE6FyHibhOc41Qkw--
X-Sonic-MF: <deaner92@yahoo.com>
X-Sonic-ID: bd98e620-d938-40c4-8a3f-5b21ebedd5ce
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.bf2.yahoo.com with HTTP; Tue, 20 Oct 2026 15:13:37 +0000
Received: by hermes--production-bf1-6d6877594b-4fmm8 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c27b5baec59ebcab6bc6425e1a3166a1;
          Tue, 20 Oct 2026 15:13:32 +0000 (UTC)
Message-ID: <8365f405-2686-4ea3-b216-7928b826f6a1@yahoo.com>
Date: Tue, 20 Oct 2026 09:13:26 -0600
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dt-bindings: pwm: Convert NXP PCA9685 PWM controller
 to DT schema
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261012140346.3065-1-deaner92.ref@yahoo.com>
 <20261012140346.3065-1-deaner92@yahoo.com> <atH835VJLqo_mdjY@monoceros>
Content-Language: en-US
From: Jeremy Clifton <deaner92@yahoo.com>
In-Reply-To: <atH835VJLqo_mdjY@monoceros>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.26740 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 10/16/26 4:33 AM, Uwe Kleine-König wrote:
> Hello Jeremy,
> 
> On Mon, Oct 12, 2026 at 02:03:46PM +0000, Jeremy Dean Clifton wrote:
>> +maintainers:
>> +  - Jeremy Dean Clifton <deaner92@yahoo.com>
> 
> What kind of commitment do you plan for this maintainer role? Do you
> have the hardware?
> 

I don't have the hardware, but I'm willing to get it and test on
it if it comes to that. I'm glad to answer questions about the binding
and to review future changes to it, also.

If you'd rather have someone closer to the driver listed as maintainer
instead, that's fine with me too. I'm happy with either possibility.

Jeremy

> Best regards
> Uwe

