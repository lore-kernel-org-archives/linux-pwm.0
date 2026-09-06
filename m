Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C7A427F8F
	for <linux-pwm@vger.kernel.org>; Sun,  6 Sep 2026 11:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788694822; cv=none; b=LHC8Ofa3sA/DKB2fNB358Oi7zFTjAHudzwVbqgeOcCrDep2eJw6SFqbndqp9eNKaCu1Aze3TkUeXGoGsXVw9Z2lAvuiBD3sWvqlEyD7ho78l5xuYtBCrXcFv63xNMTMGyrlrELRR3/FMKvl6Zy+UBL7x4lgvfWeSs40DF3Pk7ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788694822; c=relaxed/simple;
	bh=30Yz9Elei6VI66bk5i4Y7ZNktd4r3jSz3yxXPEN1eDM=;
	h=Message-ID:MIME-Version:From:To:Cc:Date:Subject:Content-Type; b=pVgj5pnokgaCrEEDRTZDdQaEE8qrM4+CUB7QGAuz4kX3dfdXM/yL0NKMpVTVAOA5bXBajKUEbRH9whsUtNs/3wG1lqOmSvuWKVg7Rkd7JBtVoKmNWKvsHcj/Nj3dgLKIBwX0PzajGzwrRfMgA6DHD9TP/GDUPQr9KQPfsTY/hpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pCFUyyPH; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pCFUyyPH"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so2091805a91.0
        for <linux-pwm@vger.kernel.org>; Sun, 06 Sep 2026 04:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788694809; x=1789299609; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:date:cc:to:from
         :mime-version:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zq5M3OTpr2g6eiAg252Kka23Tri2IujEhHRTMO6gelw=;
        b=pCFUyyPHQuZXN3nTdBKWgoNeZFE6TbnSxY2t6xxT2euZ17F5yP+5GZG4DsU0Kio7bV
         1lk8Fq+SHhaButOWAybMbq8m8te9gkFHIFDwd3vPbJtbnlomdBU9mFGAbBaTSJa7ZTvf
         TnU5qnvSedR6dv7O37omvCVLUxdL4BUkdxX1vFRB8zPhITnG8B0xe45b5NjvhmmHP+Cc
         Kx4XVxKo6265bevfpLWzdA/zhdyZkUveWp7y8FOsXGoMF78Pig/uyWWiLudvQSOFD/7v
         BZYI+37/Myd+LPQLT/MZOt2EgSC7E0yrWNbMXka32W4ibIhGXuA06v3uip7J0w70By2Y
         xXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788694809; x=1789299609;
        h=content-transfer-encoding:content-type:subject:date:cc:to:from
         :mime-version:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zq5M3OTpr2g6eiAg252Kka23Tri2IujEhHRTMO6gelw=;
        b=QvxmEHK4+7SLcp4y+ob5Bw3AmYO1Gn47bXfk1OOpBFJR5peJu7lhu3Xvn/eDFkCy6W
         UdR+NEZnJ2ZWwvwezbbW7DoAIs2aAcMw0122hjBZ9KiMwIdx3ogKbnmwHRrTkZXx+IKa
         JIRIICG+GNxnjmjEK9oya8eCNUaP37m43tMfdbqwVc2VccAKtlIEK+0p5rlhanjieDNc
         jACkRTDRr37z6hsEl8ip6KQLg3kjCeIT/VrR+WpLB9w2S1rFoug15/P56Nbb39LH8KXr
         36G5oVtfDZydnudtm8FN0Uajcat8GYR+pw4a12jrZQHvaLOA0SLtpy+Emm7D7EYGsNA5
         qBUQ==
X-Forwarded-Encrypted: i=1; AKwUvBxQKwYjtimM3PP3OvapL/69rojY3hQRnEIeiv7twozI8ziYfOOAaCEXcWakXrfgAari7igu5H0Zjfs=@vger.kernel.org
X-Gm-Message-State: AFuF++mvwZyGCDPM9KCJF9Ee0p7OKb0CaePZaFdj3NJgtCH8xVghdKOx
	rjefGEPXF+THMx/V4uxjZLj45acqqa9ho4ifINm0yxj9om8tikbosS4U
X-Gm-Gg: AYBFou34eD/c45UoQYrkabBOJ7lAi9t7T4bAN9y6R15XleYLOcQAm5AczQTXLbDFwk7
	5wOZXgWm/HB0vyyAFBrbH6G4RkAvpy80evIa/Pb/ZdEhkba9LNEkr52qnq4/0K7uNowEs8A9gj/
	PgacP9cMl+ar4dOFGDFJoOttttrA6kbH3UjikuOZGD7PQ3C/YfKyuxqma8D7VOdBdcvFIfSiGxr
	hvPEt5fkHK/egvIE5Xz/uiv52nQ4l7Ryyf1hSqzF17kZ31fgMNJ6l5NaaEf/dZhCwqB2eTwPAlC
	WmJWGtlI9MITdfJqjEVVf6hnXfPGBIfd1g2xyzKH1Ud8zyf8MoK8tzE3bWFbNgd+LUwiJFr598u
	vjk9DJgyy7XSVH0AQaCervUDilPJxgdKcSg/f4up6Ona4Ljhbepy4Ny4Kv5U+KTCC1BwTVln90J
	fBrq6VM68PsAMhKP2yK8olLYvxJyyo7pduV7kF3D4yImTM6T4NdcMDhoO/jATxRdOvwa/f+nZV6
	PTNsykBPOo8KioWYoEUlG+ZuIrCUtSHkDy9UnJO1T3sH7xgbfyJj6EH/w==
X-Received: by 2002:a17:90b:5807:b0:398:9be9:ab8c with SMTP id 98e67ed59e1d1-39b26229bd7mr27188589a91.17.1788694809187;
        Sun, 06 Sep 2026 04:40:09 -0700 (PDT)
Received: from manush ([2406:7400:94:7a79:f149:be84:942d:9300])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339885d29esm22094892eec.2.2026.09.06.04.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 04:40:08 -0700 (PDT)
Message-ID: <6a9d5118.a865c849.172a3c.4f1f@mx.google.com>
X-Mailer: git-send-email 2.46.2.windows.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Manush Prajwal" <manushprajwal555@gmail.com>
To: ukleinek@kernel.org
Cc: lee@kernel.org, linux-pwm@vger.kernel.org, mfd@lists.linux.dev,
 linux-kernel@vger.kernel.org
Date: 6 Sep 2026 17:10:07 +0530
Subject: [PATCH v2] pwm: lp3943: validate DT output indices in
 lp3943_pwm_parse_dt()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The ti,pwm0/ti,pwm1 devicetree properties are raw u32 arrays nami=
ng=0D=0Awhich of the 16 physical LP3943 outputs (0-15, per the do=
cumented=0D=0Abinding and the 16-entry enum lp3943_pwm_output) ea=
ch PWM channel=0D=0Adrives. lp3943_pwm_parse_dt() reads these val=
ues straight from the=0D=0Adevicetree with of_property_read_u32_a=
rray() and stores them in=0D=0Apwm_map->output[] without checking=
 they are actually in range.=0D=0A=0D=0ABoth consumers of pwm_map=
->output[] then use an out-of-range value=0D=0Adirectly as an ind=
ex/bit-offset with no bounds check of their own:=0D=0A=0D=0A - lp=
3943_pwm_request_map() does=0D=0A       test_and_set_bit(offset, =
&lp3943->pin_used)=0D=0A   with offset taken straight from output=
[i], corrupting memory beyond=0D=0A   the single 'unsigned long p=
in_used' field for offset >=3D BITS_PER_LONG.=0D=0A=0D=0A - lp394=
3_pwm_set_mode() does=0D=0A       mux[index].reg / .mask / .shift=
=0D=0A   with index taken straight from output[i], reading past t=
he 16-entry=0D=0A   lp3943_mux_cfg[] array and then issuing a reg=
map write built from=0D=0A   whatever garbage register/mask/shift=
 values were read out of bounds.=0D=0A=0D=0AA devicetree (malform=
ed board file or a loaded overlay) with an=0D=0Aout-of-range ti,p=
wm0/ti,pwm1 value is enough to reach either path;=0D=0Anothing up=
stream of these two functions validates the value.=0D=0A=0D=0AAdd=
 a range check in lp3943_pwm_parse_dt() right after the values ar=
e=0D=0Aread, rejecting the devicetree with -EINVAL before any out=
-of-range=0D=0Avalue can reach pwm_map->output[]. Check explicitl=
y for negative=0D=0Avalues in addition to the upper bound: enum l=
p3943_pwm_output's=0D=0Aunderlying integer representation is impl=
ementation-defined per the C=0D=0Astandard, so do not rely on the=
 compiler having chosen an unsigned=0D=0Atype for it even though =
it always does in practice for GCC (verified=0D=0Aempirically, wi=
th and without -fshort-enums, since none of the=0D=0Aenumerators =
are negative). Add the LP3943_NUM_OUTPUTS(16) constant=0D=0Anext =
to the existing enum it bounds, alongside the existing=0D=0ALP394=
3_NUM_PWMS(2) constant.=0D=0A=0D=0ASigned-off-by: Manush Prajwal =
<manushprajwal555@gmail.com>=0D=0A---=0D=0AChanges since v1:=0D=0A=
 - Sashiko AI review flagged that the bounds check could theoreti=
cally=0D=0A   be bypassed by a devicetree value with the MSB set,=
 if the compiler=0D=0A   chose a signed underlying type for enum =
lp3943_pwm_output. I checked=0D=0A   this empirically with gcc 13=
.2.0, both with and without=0D=0A   -fshort-enums: since none of =
the enum's values are negative, gcc=0D=0A   always picks an unsig=
ned underlying type, so output[j] >=3D 16 already=0D=0A   rejects=
 such values today. Added the explicit "< 0" check anyway,=0D=0A =
  since the C standard leaves the enum's underlying type=0D=0A   =
implementation-defined and the check costs nothing.=0D=0A - The s=
ame review also flagged a missing NULL check on=0D=0A   pdata->pw=
ms[hwpwm] in lp3943_pwm_request_map() as a pre-existing,=0D=0A   =
separate bug (not introduced by this patch, confirmed by=0D=0A   =
inspection) - sending that as its own follow-up patch rather than=
=0D=0A   folding an unrelated fix in here.=0D=0A=0D=0A drivers/pw=
m/pwm-lp3943.c   | 7 ++++++-=0D=0A include/linux/mfd/lp3943.h | 2=
 ++=0D=0A 2 files changed, 8 insertions(+), 1 deletion(-)=0D=0A=0D=0A=
diff --git a/drivers/pwm/pwm-lp3943.c b/drivers/pwm/pwm-lp3943.c=0D=0A=
index 10537e74b..e8bb8dbb9 100644=0D=0A--- a/drivers/pwm/pwm-lp39=
43.c=0D=0A+++ b/drivers/pwm/pwm-lp3943.c=0D=0A@@ -218,7 +218,7 @@=
 static int lp3943_pwm_parse_dt(struct device *dev,=0D=0A 	struct=
 lp3943_platform_data *pdata;=0D=0A 	struct lp3943_pwm_map *pwm_m=
ap;=0D=0A 	enum lp3943_pwm_output *output;=0D=0A-	int i, err, num=
_outputs, count =3D 0;=0D=0A+	int i, j, err, num_outputs, count =3D=
 0;=0D=0A =0D=0A 	if (!node)=0D=0A 		return -EINVAL;=0D=0A@@ -247=
,6 +247,11 @@ static int lp3943_pwm_parse_dt(struct device *dev,=0D=0A=
 		if (err)=0D=0A 			return err;=0D=0A =0D=0A+		for (j =3D 0; j <=
 num_outputs; j++) {=0D=0A+			if (output[j] < 0 || output[j] >=3D=
 LP3943_NUM_OUTPUTS)=0D=0A+				return -EINVAL;=0D=0A+		}=0D=0A+=0D=0A=
 		pwm_map =3D devm_kzalloc(dev, sizeof(*pwm_map), GFP_KERNEL);=0D=0A=
 		if (!pwm_map)=0D=0A 			return -ENOMEM;=0D=0Adiff --git a/inclu=
de/linux/mfd/lp3943.h b/include/linux/mfd/lp3943.h=0D=0Aindex 5d2=
d172d3..844938ca7 100644=0D=0A--- a/include/linux/mfd/lp3943.h=0D=0A=
+++ b/include/linux/mfd/lp3943.h=0D=0A@@ -53,6 +53,8 @@ enum lp39=
43_pwm_output {=0D=0A 	LP3943_PWM_OUT15,=0D=0A };=0D=0A =0D=0A+#d=
efine LP3943_NUM_OUTPUTS		16=0D=0A+=0D=0A /*=0D=0A  * struct lp39=
43_pwm_map=0D=0A  * @output: Output pins which are mapped to each=
 PWM channel=0D=0A-- =0D=0A2.46.2.windows.1=0D=0A

