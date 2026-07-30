Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC1A3D75A1
	for <linux-pwm@vger.kernel.org>; Thu, 30 Jul 2026 21:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785447050; cv=none; b=rXvmzBy3fZp407ftXXycYQPjJ7ikHNK/vhaABcHfUB315KafBJ69kK+5ZEXcsis9WSM9ttYxpnbbDs2Vqz8DtgVJnVLgKliorKxRcqXD/MUrTPi2vCYUx56OZ2lz+wP1lP3bRYG1D5aUgBOQFN/UpHIsdyASDNAEaiNnmOqDngg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785447050; c=relaxed/simple;
	bh=+gw83Mh3Ir+pTpfrq0+pitALUCJUqx97EkYCdiBEbRg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kSQZoFODJ2d1o5lDEuY8W8cSSD27jmBvmhMf6O5ljAMQczcHptb0jrteN1p2jTKIaKXh8Zidt7I3kDddpUqqlXTkQc6JH+iIO5gzgVqfA4XzyTGda3Slh07xZzPSnfFD+btajNeiMFVUrq/CMsBuLtKnxwhQgUymEWLgAg2Cwds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPYCuCDM; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPYCuCDM"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c99eaa1f020so249058a12.2
        for <linux-pwm@vger.kernel.org>; Thu, 30 Jul 2026 14:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785447045; x=1786051845; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tv7r0pILyVz8vcjgz8J3/h+ifgsbbGqBLwmu7dyifLA=;
        b=GPYCuCDMKNN9IXev/qhPXsoqGCN+ktSnjkpIwop4bw4KNbxoJNX2sfCuxqmxiFJNVY
         BtjMtUtAc/ZPBJI8GgG4dl5hnIvnkLvLbbwaaa2IIBPE3PzTQWgL876ySkjox4Xzy+4f
         B8vGV40tbOJK5dlZEnCHcEnWB3FD0bEUduE3BQ6GaN2Kv+02oQ2zP8IdVBb66PRgkG9r
         7L+d0nm/rBiHpZSKUKMV8IQIqo3Xi5yVKKE+wikxzXnhZmi+GH+REPSYkKB8PNOrDrk6
         W2cv2hZ/fzulqksf1AuZazyjNmUVpi0n8LbHVVCQeBQJaIm83IxN9XWNHZPbTSyPv/jj
         EDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785447045; x=1786051845;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tv7r0pILyVz8vcjgz8J3/h+ifgsbbGqBLwmu7dyifLA=;
        b=njJWmWGgouoQW6YTryrX+BGsSkW9u6/aN8evOwCqqNqtBqKs0SgZjlUH8lbMHpLyid
         A3bZCVU7gjANlgTGDJDVtZ3ZZLZ9417NArgVu6lNfDEp/WZXpUE2Dxhofx3b1D7RVjs7
         CjpCbZ//x5zT9qDykMq28HePiP8fvu0U8zpKuSC4MxhF/+N15jn05WZ9RmD1l+nNUD+8
         XnDDiktXUa2MYi9Slx2DmAtAjxo0WaxmlPDpHHpSDcCEm8HQ79vW/AU2Ko/ZguYGjpar
         iIr9CWzU5DgWSprzt22yRRIGnZbagL3gewyl5nVlqA56V7xHr+n5KnSiE48U8tSEG98t
         rqdg==
X-Forwarded-Encrypted: i=1; AHgh+Ro4aZ6jUez/n4uvOHWxJCwZvWNhXRFx9eFfJCYG+eEop8JNEa0a0Oni6N/IE2Y0ZXp7Tgxln0/WwKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1DYDeASyec+eYeFFifijjqL3ZX1zF3hZR1P2Jbl/5n4Uq1MC6
	wPI2FduZF1coT619N8nmgoeT94Qe4SE2vT+/t++V9CEJ8Z5uocRcULSH
X-Gm-Gg: AR+sD13f+wIdi0Ge/TpjfVO1MJkTt6rfjJXBb+KRZwabgtlzgUV4g7qttCUpqMhyqhe
	lcLNNK5005HkrelG4Bp4JxJEo1qbuuqBEQBHJJ+La/xqoG+w9U34AbIEmos/nZE5to3UT56nPL/
	BYuTnf/n7XH2g81/PpC9pYyAr9LU7vCYjuVxikq7flgXBzp5iKX4LEVIkjc+PLqZn1kL7tn6JwO
	GMzmy5D91Iz0YK33RgI6MvilAAUdwMeiIArvff2/XdpFtduz/RTQw54t7cHIzJ6yopbyeZ0XhAG
	h1nWeudydTdRheZEy/SPUhk6sDJUcdZVvEEyjVTVWZvl3BNd0HeBTweW4UsQt0PU6HuvgYi2X07
	Ievi3KIJO9rvG7zH4FGH/TK0A9YS5zStxzyp04uoThcguteIdz8kJWdC7mszFp2reznyRqFFy2v
	Prd8Ky3HOjDSEhM6wfJDL06X9L7DAe3fw3NFfK1SzjaEAEYFwmkNwhIuLSr9S92iMBCBpqRQL6q
	ne/
X-Received: by 2002:a17:902:f64c:b0:2c9:c46b:1286 with SMTP id d9443c01a7336-2d035ce5f7cmr42775525ad.34.1785447045138;
        Thu, 30 Jul 2026 14:30:45 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504d2ec2asm28584728eec.21.2026.07.30.14.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 14:30:43 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Thu, 30 Jul 2026 18:29:59 -0300
Subject: [hwmon-next PATCH v5 4/4] hwmon: (adt7470) Add thermal zone sensor
 support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-adt7470_thermalzone-v5-4-42995a6bb8c5@gmail.com>
References: <20260730-adt7470_thermalzone-v5-0-42995a6bb8c5@gmail.com>
In-Reply-To: <20260730-adt7470_thermalzone-v5-0-42995a6bb8c5@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Chris Packham <chris.packham@alliedtelesis.co.nz>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Darrick J. Wong" <djwong@us.ibm.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>, linux-pwm@vger.kernel.org
X-Mailer: b4 0.15.2

Register the ADT7470 temperature channels as thermal zone sensors.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/hwmon/adt7470.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
index eeec3db0da88..f652532f2f32 100644
--- a/drivers/hwmon/adt7470.c
+++ b/drivers/hwmon/adt7470.c
@@ -1396,6 +1396,8 @@ static const struct hwmon_ops adt7470_hwmon_ops = {
 };
 
 static const struct hwmon_channel_info * const adt7470_info[] = {
+	HWMON_CHANNEL_INFO(chip,
+			   HWMON_C_REGISTER_TZ),
 	HWMON_CHANNEL_INFO(temp,
 			   HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX | HWMON_T_ALARM,
 			   HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX | HWMON_T_ALARM,

-- 
2.55.0

