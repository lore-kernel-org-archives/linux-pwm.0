Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4561E3644A4
	for <linux-pwm@vger.kernel.org>; Sun,  6 Sep 2026 11:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788694921; cv=none; b=Z8zg2Fn3NzqxOXhzbsMIOkOfqrYyUJpf3/dzrH8be63rTkvVJCCxMh/gPjx5F4LZgXvPMVUMtC6MnOQgou2/9VRPb94TKBhJYUeF6r3gkFjhWwk8AYnf54kyaGdMy1EY58Y5uEZ1v7aKMgcVVJYvdRey2ENCwzOXFFXbYAghnXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788694921; c=relaxed/simple;
	bh=9wGZ3uW3JCvaV6GCi4Pwu367A/BCj54JekdWGEgTalY=;
	h=Message-ID:MIME-Version:From:To:Cc:Date:Subject:Content-Type; b=YfXrQ6OQKr6LFggMLfhOkkmHifgxMgSTTpC3FJC6xq48bHpgfHlrk0jHUYFPGxJg7TtlNp1N8f+3IjkoYpSMAHMxVewp1GAwFgcnKPPdCgwPrsxz4KBXCuRKK1Con0QWWouZnEzDnAqn/dJPBYtFPn4h2Ffx9qBAeKHEWzfUJfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdvJmlIV; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdvJmlIV"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc1cb472b76so2159961a12.0
        for <linux-pwm@vger.kernel.org>; Sun, 06 Sep 2026 04:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788694919; x=1789299719; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:date:cc:to:from
         :mime-version:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sj44NAeIxHURpVAbMjqn23Nd1CJqn9f7LlCNmzDV2Qw=;
        b=NdvJmlIVJ5bUv4G2vOhKPudPhMkeS8RQKx5uA6itgWq6wFgxprIXZ9ynwX01zQ5yap
         9GlrqnxJ0ju6rbqfMXgVQvG1jtSrDDlCZpAaLR2g7agXYuRND7B/Rl8CDbGWV0IPPwQE
         foyGAmtycCua1462nheqK+P7NHAPeDYEotLU921wmtLa5kEE7HO7BuSl+k//t74sAhua
         VtfLoHKPpWQ8/6aBCJ39mjPPkWBjjPsqZBhntCrdHL31eaTerqB+KVv1NNRYyOxP7VCV
         sVX5CnU+D5HN/JXpIBtYos4XRmearkbxHRMpjstpseadMPDJP0eijjxCnAZmHOX8uj8W
         v1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788694919; x=1789299719;
        h=content-transfer-encoding:content-type:subject:date:cc:to:from
         :mime-version:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Sj44NAeIxHURpVAbMjqn23Nd1CJqn9f7LlCNmzDV2Qw=;
        b=qJomcT8JD2OZVfl4EFc71LDKwoWrslQF+rp/yOYEwBt3APTV7qvOsafok/OFeqzaCb
         qdLzrgjS9odwCjfPRkGZiANazV4pkyvHTyvbiTQT6xO+p4NqFzYeSA/A20obdXEX1NYw
         YxZMOhqbqwzHkdxrYz6HP42Opcz7ju5CujCVfOIIJU/G8B7yVlqjy4EPWKRrfgDabelv
         aC+ap7g5ZKxbiDPhIZDzQlXEUjSuTC4QSD0brE/+C8CEeIh4PCwkrIkwY/Y/aJzIcfyG
         QQ0CZYQ0XM9vtkIvpIGX19nAo4fB0fH/DFBU2lsRqELeZ7bnxt7/IQNC5rl5v1ljEvBw
         TT0g==
X-Gm-Message-State: AFuF++lDvikO/8IoPMVf5FUWMgaovIWT33fyjX98T/q+4mUVZrVD4N1W
	XYEO4oyxgScTNI5SLwYSCBqqKEMaXPj1yop7TknuQQYyyrePT/6wDW6C3xFz/19IdWM=
X-Gm-Gg: AYBFou2TWm4gcP9mr+sgcbSpXMnDfET7nEuQqWLE/nZrfyrO4TsLS51bUsI9ngtUuiD
	JmsJJM2fjOIvjLW29Px76pXOYrWqZR5l1eMxMstMMIgKDt6SZrG4t/qXkQSc5cYavK/F7GJWC8x
	RkPtip4wDcyzS4ufxVg+XnKNxL2gssLsQRg8MXBBGiVUc5pyTn8Sv1FNEqHexhRKYOpqbNkUd2b
	db8SyTcYzXg7KbdPeBtFqUIdyn/V63ST9VkAYb3StfDNaiZeqkOrNC4Whauz+wYRpT0OwAiLMGl
	+kA5sOZdJoUMScFiQ9nIrBlsmF3kaiV0sihFuei1pp8k9aQrcZBeFLwDd7bVzjF8KH3sFk31Ybf
	hpOYR4u/n1BphLWtA1gaZgrtxE0DsJVmLYq9tAg6jYalZDIBagWAfZBN0sbhaiUPZqdkIK56iuU
	4KEUCmtFDy+HJV5LBwr+iL9BONkHf7/j3mp1JbUEtabS+khqQ03//LfcCyLEoSvU1xOj2mtGySy
	wCCSLXznymAERd+SGcxevQlKo7bHMth1dEW0030g3QZCEjc5EGVG2lJ2w==
X-Received: by 2002:a05:6a20:568e:b0:3c4:4272:b400 with SMTP id adf61e73a8af0-3da39fd2525mr26788303637.18.1788694919353;
        Sun, 06 Sep 2026 04:41:59 -0700 (PDT)
Received: from manush ([2406:7400:94:7a79:f149:be84:942d:9300])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b8f44d7sm19568798eec.22.2026.09.06.04.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 04:41:59 -0700 (PDT)
Message-ID: <6a9d5187.d63de05c.175391.a17c@mx.google.com>
X-Mailer: git-send-email 2.46.2.windows.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Manush Prajwal" <manushprajwal555@gmail.com>
To: ukleinek@kernel.org
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Date: 6 Sep 2026 17:11:58 +0530
Subject: [PATCH] pwm: lp3943: fix NULL pointer dereference for an
 unconfigured channel
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

lp3943_pwm_probe() unconditionally registers a pwmchip with=0D=0A=
LP3943_NUM_PWMS(2) hwpwm channels, but lp3943_pwm_parse_dt() only=
=0D=0Apopulates pdata->pwms[i] for the channels whose ti,pwm0/ti,=
pwm1=0D=0Aproperty is actually present in the devicetree (the bin=
ding=0D=0Aexplicitly allows each PWM generator to drive zero or m=
ore outputs,=0D=0Aand lp3943_pwm_parse_dt() only fails outright w=
ith -ENODATA if=0D=0A*neither* property is present). A devicetree=
 that configures only one=0D=0Aof the two channels leaves pdata->=
pwms[] NULL for the other.=0D=0A=0D=0Alp3943_pwm_request_map() de=
references pdata->pwms[hwpwm] with no NULL=0D=0Acheck:=0D=0A=0D=0A=
	pwm_map->output =3D pdata->pwms[hwpwm]->output;=0D=0A	pwm_map->n=
um_outputs =3D pdata->pwms[hwpwm]->num_outputs;=0D=0A=0D=0Aso req=
uesting the unconfigured channel (e.g. exporting it from=0D=0Asys=
fs) crashes with a NULL pointer dereference instead of failing=0D=0A=
cleanly.=0D=0A=0D=0AReturn -ENODEV from lp3943_pwm_request_map() =
when the channel was=0D=0Anever configured, before the pointer is=
 dereferenced. The caller,=0D=0Alp3943_pwm_request(), already pro=
pagates an ERR_PTR return correctly=0D=0A(it does so today for th=
e existing -EBUSY case).=0D=0A=0D=0AReported-by: Sashiko AI revie=
w <sashiko-bot@kernel.org>=0D=0ACloses: https://sashiko.dev/#/pat=
chset/6a9d4c6b.79b5ea6e.147aa1.5883@mx.google.com?part=3D1=0D=0AS=
igned-off-by: Manush Prajwal <manushprajwal555@gmail.com>=0D=0A--=
-=0D=0A drivers/pwm/pwm-lp3943.c | 3 +++=0D=0A 1 file changed, 3 =
insertions(+)=0D=0A=0D=0Adiff --git a/drivers/pwm/pwm-lp3943.c b/=
drivers/pwm/pwm-lp3943.c=0D=0Aindex e8bb8dbb9..956d22053 100644=0D=0A=
--- a/drivers/pwm/pwm-lp3943.c=0D=0A+++ b/drivers/pwm/pwm-lp3943.=
c=0D=0A@@ -38,6 +38,9 @@ lp3943_pwm_request_map(struct lp3943_pwm=
 *lp3943_pwm, int hwpwm)=0D=0A 	struct lp3943_pwm_map *pwm_map =3D=
 &lp3943_pwm->pwm_map[hwpwm];=0D=0A 	int i, offset;=0D=0A =0D=0A+=
	if (!pdata->pwms[hwpwm])=0D=0A+		return ERR_PTR(-ENODEV);=0D=0A+=
=0D=0A 	pwm_map->output =3D pdata->pwms[hwpwm]->output;=0D=0A 	pw=
m_map->num_outputs =3D pdata->pwms[hwpwm]->num_outputs;=0D=0A =0D=0A=
-- =0D=0A2.46.2.windows.1=0D=0A

