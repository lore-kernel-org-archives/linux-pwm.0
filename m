Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C692238B7B0
	for <linux-pwm@vger.kernel.org>; Sun,  6 Sep 2026 11:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788693614; cv=none; b=P53XyKI3vYAvTz8hBTBlbUdp1G7CceqZ2vfmPuQtpaCwPvu12CwMCLLxzMM/HiwYzEFR2fJRQqxc6if5azRPXGAlGEDVFQ6HEsnZ+3wywZsSNu8Uos7jLZU69VNgEL2foth+cuZxbVNOELoHyL9a4xGg4jzn9RdwJQeEJqAoIvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788693614; c=relaxed/simple;
	bh=jLuV+lLqQK8/EHcVuPKgeyCNnuLNb1rLsMWCYlCW1hI=;
	h=Message-ID:MIME-Version:From:To:Cc:Date:Subject:Content-Type; b=HbbHKMaQTxDwBRpWd38aytDzIOKUAv+N7O+9Cm3HtnY8DJ5225Y7ZW8lfKKW/SJlGBNKpmDbiYBCcsz34hBbN+7cl3DhduovpDadbp2n/YFA7o4vw1trm/+1d3z3DeCJ5t3WiyG9SWhPlkCkY26+vJ+Aa09tP7fBVQXKTasCjhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QgZlloAv; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgZlloAv"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d6e954afbdso15957595ad.2
        for <linux-pwm@vger.kernel.org>; Sun, 06 Sep 2026 04:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788693612; x=1789298412; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:date:cc:to:from
         :mime-version:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PTH7GUXLcuozQUUFEaYKkQ5+81ENlZ2w0hwg8hOzpBI=;
        b=QgZlloAv1MPMgIxHChc9lSkckWukcBGzaZM7oD2D6JtYuVrkfSuOJ0CvZ1D4ImHoF8
         kN0ze6rYdGFESyrhLJQe+ddpD60CGt9HfcedYlJlFfxMC31eB39vyBQlhEIrpRM2hOMN
         JcdAnvQW+RhweDLLAmIzJ7XtrFyfRHOh4iQmPmTHNUrdPt3e/0lOsdccGhsteZtHl2xy
         LAwoz6PZmrXyTUoLomecYV10ha9Oa1sXQgPSQowfB14mceb81/Dr9NbFa8odcfXlt2Jo
         I65WyiPcKXO/2tAAVOecmFfsW+LO5z15xbZvE12Z4mMX6K8OameKyFle987x1GVLIcRV
         9ywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788693612; x=1789298412;
        h=content-transfer-encoding:content-type:subject:date:cc:to:from
         :mime-version:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PTH7GUXLcuozQUUFEaYKkQ5+81ENlZ2w0hwg8hOzpBI=;
        b=VYqnwtLovEmNhtnEBuXQ3iM0+64/RFV3PJr92f3113SfhzDc4jpGsY+o6q6sFCEpVk
         k2eMhTQbHq+L08Zk5jGUY/yfwkrG+b6+Vl7GpqClD5bkIW7snf2RqYT74dTn3oTQ9KGT
         IrCoJqFluxEQk/dJFI6oa7PO0eEBwiYyzshYhJ7lIo1Iacx5OMiFuoFGicn86V25Jh6Z
         X2hlD6HCQO4YZvGnR7WwE7w3n9O1hKacZi4ExPqyZqRvT+gHMyKoEiWQFs+Iw13cCzIE
         qOsLCpmeUGgmgcUcw7wSkNksfyIcD4n/aCI4z+HkxX4zPKbnIRohOX/91dG0plzXDj2S
         dEjg==
X-Forwarded-Encrypted: i=1; AKwUvBynExN58OPtEmcjngwt4FA73NmZ3hQiHgG4hZDsSa6lo4stigG2YOFyMvhY005Tr8zTyT70iTc/OAE=@vger.kernel.org
X-Gm-Message-State: AFuF++mSB/lg2EGVrrm7Uv9ogtEdn+F9F07e4Y3rrDw6Ed6Jq+SKNbPF
	YyFK/jnl43CQFBF1On7/3GupLQvXSJcf0LB1lRylWAqJy/FlFOjfFI5K
X-Gm-Gg: AYBFou05j5JnEmtGbJ6kWR8+8vjqvkPn6r7nOufgRwE8JndqAAKPkfgCbFzAqloVdf9
	O+0Ha6Hk6EqV/JhO45IWgisw9GJef0gYEK+Y1kwwWfnWV/bDgxGCgYqYpPCGQkmA+XRsTcXXLMt
	hVntu9TXBMQu5V0oTgQ6ZVRXfN98dCpajXiuP0Trxy1d+ZFAbrzFkkNocyARk6u5zO6tf0yygBM
	C0EN9OHYPEl4/h3T5ziRAGmxyEWJgrfWXFfJqzzqLvNNfhRBD05tbSk4IWynDSwegQpJcoZ8GWl
	vtSXiMWvQ7QzmR1dy9N6Ichm8rp3Q/zkqWoQ06CExj2Jup1gZn5l8isOsJADV185agixm0TUV/d
	Ykk+G9KyuE7Gr9osP7esBEWiKY6oPkN6tzyoSi9q+IYlT95NIT82iY66uzmLpq9tH9DuvAT/h9O
	2rF4I7LKyLYaFuXzlzXT8IQ00AYorFcuDG7WdLoeGOJyjJhqJs/f/dOK0/xVENBV5f2gyJPn/Md
	YV8L2+tELVmT9LI0+irhwbl9fAf6jns6p9OPYSyTC9dB0YWdnNJHhZ5mg==
X-Received: by 2002:a17:903:11c8:b0:2d8:d4de:fa80 with SMTP id d9443c01a7336-2db1235721dmr234116345ad.4.1788693611959;
        Sun, 06 Sep 2026 04:20:11 -0700 (PDT)
Received: from manush ([2406:7400:94:7a79:f149:be84:942d:9300])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339aa36b37sm19291515eec.14.2026.09.06.04.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 04:20:11 -0700 (PDT)
Message-ID: <6a9d4c6b.79b5ea6e.147aa1.5883@mx.google.com>
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
Date: 6 Sep 2026 16:50:10 +0530
Subject: [PATCH] pwm: lp3943: validate DT output indices in
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
-of-range=0D=0Avalue can reach pwm_map->output[]. Add the LP3943_=
NUM_OUTPUTS(16)=0D=0Aconstant next to the existing enum it bounds=
, alongside the existing=0D=0ALP3943_NUM_PWMS(2) constant.=0D=0A=0D=0A=
Signed-off-by: Manush Prajwal <manushprajwal555@gmail.com>=0D=0A-=
--=0D=0A drivers/pwm/pwm-lp3943.c   | 7 ++++++-=0D=0A include/lin=
ux/mfd/lp3943.h | 2 ++=0D=0A 2 files changed, 8 insertions(+), 1 =
deletion(-)=0D=0A=0D=0Adiff --git a/drivers/pwm/pwm-lp3943.c b/dr=
ivers/pwm/pwm-lp3943.c=0D=0Aindex 10537e74b..1ce2a1bbc 100644=0D=0A=
--- a/drivers/pwm/pwm-lp3943.c=0D=0A+++ b/drivers/pwm/pwm-lp3943.=
c=0D=0A@@ -218,7 +218,7 @@ static int lp3943_pwm_parse_dt(struct =
device *dev,=0D=0A 	struct lp3943_platform_data *pdata;=0D=0A 	st=
ruct lp3943_pwm_map *pwm_map;=0D=0A 	enum lp3943_pwm_output *outp=
ut;=0D=0A-	int i, err, num_outputs, count =3D 0;=0D=0A+	int i, j,=
 err, num_outputs, count =3D 0;=0D=0A =0D=0A 	if (!node)=0D=0A 		=
return -EINVAL;=0D=0A@@ -247,6 +247,11 @@ static int lp3943_pwm_p=
arse_dt(struct device *dev,=0D=0A 		if (err)=0D=0A 			return err;=
=0D=0A =0D=0A+		for (j =3D 0; j < num_outputs; j++) {=0D=0A+			if=
 (output[j] >=3D LP3943_NUM_OUTPUTS)=0D=0A+				return -EINVAL;=0D=0A=
+		}=0D=0A+=0D=0A 		pwm_map =3D devm_kzalloc(dev, sizeof(*pwm_map=
), GFP_KERNEL);=0D=0A 		if (!pwm_map)=0D=0A 			return -ENOMEM;=0D=0A=
diff --git a/include/linux/mfd/lp3943.h b/include/linux/mfd/lp394=
3.h=0D=0Aindex 5d2d172d3..844938ca7 100644=0D=0A--- a/include/lin=
ux/mfd/lp3943.h=0D=0A+++ b/include/linux/mfd/lp3943.h=0D=0A@@ -53=
,6 +53,8 @@ enum lp3943_pwm_output {=0D=0A 	LP3943_PWM_OUT15,=0D=0A=
 };=0D=0A =0D=0A+#define LP3943_NUM_OUTPUTS		16=0D=0A+=0D=0A /*=0D=0A=
  * struct lp3943_pwm_map=0D=0A  * @output: Output pins which are=
 mapped to each PWM channel=0D=0A-- =0D=0A2.46.2.windows.1=0D=0A

