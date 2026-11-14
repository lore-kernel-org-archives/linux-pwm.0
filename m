Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794663983;
	b=LpbzMcV6zW37JxvIU/6oGHqHjZjldQl7CtMamAoUF6ZU1jkFiXka49GEVFHB93qKSouZ
	 e1m0JG/HbaAGzsRla1OmE4XRr7jWnlaEahRshoM0ZtbCNUzjEDVLQG76uWYYWNMHbsP7L
	 ve6Ow6DIQfAm12GyIFszx0AaaIMvsFBk+LZcS+mJqvEMfK6gc9apD7UMCe5VVwSXSfreo
	 Xrsi/kZuYqh3yiC5B61AAzV2AY9Wl/hOidSESEHPZxVhM9n+wL4fl8kJ6Icud/1xY7zUA
	 gyybDyROZNnxPN7HL/RASVWJFHWUHs3QQ1er6k7S5XFcWeFWNNpZ2Ncsfpep9dqHnuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794663983;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type:Content-Transfer-Encoding;
	bh=hxhKKH7II1y8GERDF5iah/4uc1VaD2sdq/KeGrQB7zM=;
	b=cmo51+5YPzdnP4nieYOMBR2WZ5z0cigNdXq/aDi9U/UK96qmebEpfVDlKJ3mckNXzMr/
	 MlNkTmUk8RHKaIjnccvQdrYwGDsGmx2cWC4XH5HvPcElBozOHt3JqYZKo+nk5Ar3I122c
	 myYUncX/+9AlO72XmWzwfCw53KX2o2j+YCBcQCCohXGasUQHt8rxJm7dhGe+SHjgcdPQ4
	 eh5UMt+okAbrmgM/LNfxPYMZwL7rgAdACna+z+OKzWi+wGsZWOlHaizApAKHaGZ5hr0wg
	 NkJ6iCn8pUI/9UoMakWMbvbfvobPFNluocDSjD3DJSoMWGuKPCBBxIDjkPCLBIyMw+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=flapping.org;
	spf=pass smtp.mailfrom=flapping.org;
	dkim=pass header.d=flapping.org header.i=@flapping.org header.a=rsa-sha256 header.s=fm2 header.b=KyzszYdF;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=TgfhIzt+;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25738606A32D
	for <linux-pwm@vger.kernel.org>; Sat, 14 Nov 2026 13:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25738606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flapping.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=flapping.org header.i=@flapping.org header.a=rsa-sha256 header.s=fm2 header.b=KyzszYdF;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=TgfhIzt+
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id DBF65EC0190
	for <linux-pwm@vger.kernel.org>; Sat, 14 Nov 2026 08:46:20 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sat, 14 Nov 2026 08:46:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flapping.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794663980;
	 x=1794750380; bh=hxhKKH7II1y8GERDF5iah/4uc1VaD2sdq/KeGrQB7zM=; b=
	KyzszYdF00F/c0LxZZ3Y15eS1Z5M9hGilrb6G9zQkelrC99UIPiXh9Y+8waRZmDg
	ks3cdwtIG/m9vuur8eITFNrVRBzX59YkamS2EzUsBqbQpxm6lCNhK/994DwifXcz
	uoTOuMJlHtJWamPUNtnQn3TRYM+yk6c4Dr5+VSO6hQ6UsmHjfePG3AspBBGvYH8T
	XFmcCR5ud8uWGzCJ0NnQpPoQfQ6TL9tlrRrBMu8gU70OAAgEb9cLhuRJao1lhcg5
	ug4a0v7QpXWqfBtusNjGN/dU8+MV3rXmWycWbN6eEJGavcrrGeCpG/BZIhwQibwj
	85DB58xP8mo59ibYq4hFrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794663980; x=
	1794750380; bh=hxhKKH7II1y8GERDF5iah/4uc1VaD2sdq/KeGrQB7zM=; b=T
	gfhIzt+kwtUME3A5jpJ/pnxEE6yi44aKMcGMY9cYEGXaquuwy5VDYGk5OkcaCXK6
	snM5tLj+Ws9t1CKzFet+Yb/Pq9EXgmv3PTTi+sP/nVQgKameVrnFMoD04BI0MYlZ
	G1Hy3Xolwff6RKrFwBCzPCDLZuMjbpEfB04pw47RhcTfuTXohQk92Fea5WjttFTv
	DlnCirVFyRe01aXfWpVJAUBDGBTfXngOOq8QIgTN9GpHnFcFTPPadoBIBYUq8IIH
	AtFlvSmJlhJNvCGU8E213NyNHzmaVcONurl586lUEvVtbEwIFvk9tTZdzbSE2n3A
	mgwQPRtmWLM7epgPSxiRA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=flapping.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794663980; d=flapping.org;
	mf=PHRvbW9AZmxhcHBpbmcub3JnPg==;
	rt=PGxpbnV4LXB3bUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:it4GRq/92tSQE4BhQbmKLl79pbk/OpFM3uA8+yYzMaAFvmL
	8ltvPhnSLnqP9aDk2dcaw0GQX0afxHckkLDYPUzfZ6QRJnJl3uFXGO68O9Y1vqGr
	Q1IlSyDuOhPqKow81tVBa9KbA9xFZR/wtDx13YhwYgqV2zN9yA1285cmv/P5OFu6
	S9VsxUfygFICYqk35CwmkgsboZTnDcyhlFNa+iyvO04f3p3FHnJKp6I374fX7Ld3
	vnJHLYHWZ7MEvqxlLpJ2bXgyDd/Jfkp6xd4lIEKmcnWzxuOUTBakvRbwtyzwvrct
	Jd+jtgSkkEN4SL2binwalaCC82hav5lBtivDeHA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:snB4EXilH1Gf6GI5LPdyrG0HIWBFLR5A9TIZbIeREqY=:j+eEPBMHstwFyCQ5gSQRfcc2+DkJ95TFBdMoixoDrOs=;
X-ME-Sender: <xms:LGb4au3Qx9YUsVpypEOKJ2aBHeUpkRBLlXy8E42aU4qJUkStwGRMzA>
    <xme:LGb4aivqDS9FcEOkaFHw5JXQU36IxU270ZgXCM1qNcXCMvbAT4jmHuWu2jNlcYiwr
    POkcogoz8jsVJQ9_nkvhoNvhR_Fl6vdAdyO4WxCriBd2hr6xaKoy5Cr>
X-ME-Received: <xmr:LGb4aq87tRmiJ1_gXvFoTwtTlEk6qQngB0lH82WKSG4mQ1LKKoNK9_2Gdjb4440XQcgMXup2ra85k9kSrdwwz68n>
X-ME-Proxy-Cause: dmFkZTGPyd099gFp6IoEh+SqiSCQACv4zvizj1DwHPte5hKiSVJP1TnbPevudWmZd0JrDK
    CLlS8AEAuLK3z+Qa1AJDYWjuRBzbzzZ/QZmHlUgX5lmtCvtDkEJvtBhp+/FLYTf5W1KrPG
    /w3ywMgpPLA/Skddnq+qp43vlsitQt9dd/uiru0XSnI069mVHDuVXZRp33P3x1O3hqq4R3
    2odw9rdPyqcWQQk6/BZEHKXRHOPrV3p1Hg9TxYf27qml3azOJyrSJ2ZMY+5KjZhBCab7OC
    eF9nUNaLHnQ1xpyuN0kJ3UR/Jl5FJxCKGoj1vhXsGIK+v/b/DKbEZH/AwrWSeISaUeN7WX
    VMUZdUfY9AYg++q7hsHGO2vDyTVvqjDFR/ynYjP70kW2SD4lpfQ5BPTKLYaTTKDhUAXaUZ
    QzLWepMTF6nE3aF8lmjoBZOOSiheU+Sx7dOuKRy+jyF1bIvwtauPjWcD7ECtQ9ZoeLoMh7
    uiuNZUn0rGJH45lWAwe3zTKhCnV1vjatV7mx5YM+DaVGqQ8yHn8ArXUcnNVT9zjE5N/yh5
    amebZ8HocGz9XOHrRdkIe53LMjX38CQd96uFiQzF1IoCKRSxKwuQ0GyMm/ly5+SmjFw5oH
    NUfN4ffFsnhl7/tV+UHx9f13dpWKWNobdooaCqSxbIAzgx4MiuXHGj0NNcwA
X-ME-Proxy: <xmx:LGb4amRKL1NMjOylVW704EulToRDB5S4gPt06T3Mu1mbFvhYH6jKxw>
    <xmx:LGb4agAhIwKMTed3wsMCRfq4i7rN6vb0qU-5Z8BAKXYPmTrTctFrzQ>
    <xmx:LGb4anYA7OaLb6abg9cH746HGeu0mUpj6au2bjix0ggKpn_FoUSFlg>
    <xmx:LGb4ahJH2nMVrND9HkJ0iwOhLr-DaXjPkOo-hdeNcUXzrzlcK1mPEg>
    <xmx:LGb4asy8VY94PhwJz1CEzUeMKD-6_80kNHtkbWnxHGjoYK_z44eNttjw>
Feedback-ID: i51fe4b43:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Nov 2026 08:46:14 -0500 (EST)
Date: Sat, 14 Nov 2026 22:46:12 +0900 (JST)
Message-Id: <20261114.224612.1895277862836640234.tomo@flapping.org>
To: ukleinek@kernel.org
Cc: fustini@kernel.org, guoren@kernel.org, ojeda@kernel.org,
 wefu@redhat.com, a.hindborg@kernel.org, acourbot@nvidia.com,
 aliceryhl@google.com, bjorn3_gh@protonmail.com, boqun@kernel.org,
 chenhan0017.work@gmail.com, dakr@kernel.org, daniel.almeida@collabora.com,
 gary@garyguo.net, linux-riscv@lists.infradead.org, lossin@kernel.org,
 m.wilczynski@samsung.com, tamird@kernel.org, tmgross@umich.edu,
 work@onurozkan.dev, linux-pwm@vger.kernel.org,
 rust-for-linux@vger.kernel.org, fujita.tomonori@gmail.com
Subject: Re: [PATCH v3 0/2] pwm: th1520: Fix 32-bit build with COMPILE_TEST
From: FUJITA Tomonori <tomo@flapping.org>
In-Reply-To: <20261030020209.3833766-1-tomo@flapping.org>
References: <20261030020209.3833766-1-tomo@flapping.org>
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi Uwe,

On Fri, 30 Oct 2026 11:02:07 +0900
FUJITA Tomonori <tomo@flapping.org> wrote:

> From: FUJITA Tomonori <fujita.tomonori@gmail.com>
> 
> This series fixes the 32-bit build of the TH1520 PWM driver with
> COMPILE_TEST. v2 limited COMPILE_TEST to 64BIT. Uwe asked to use the
> div helpers instead, so v3 does that.
> 
> Patch 1 adds a math module to the kernel crate with Rust versions of
> div64_u64() and DIV64_U64_ROUND_UP(). Patch 2 uses them in the driver.
> 
> The driver only needs u64 by u64 division. It does not need a 128-bit
> intermediate value like mul_u64_u64_div_u64().
> 
> Uwe, are you OK with this series going through the Rust tree?
> 
> chenhan's series [1] also adds rust/kernel/math.rs, with signed
> division helpers. Both series use the same module header, so whichever
> is applied later needs only a small rebase.
> 
> Tested with the doctests on x86_64 and 32-bit ARM QEMU.
> 
> [1] https://lore.kernel.org/rust-for-linux/20261023130413.178487-1-chenhan0017.work@gmail.com/
> 
> v3:
> - Use div helpers instead of limiting COMPILE_TEST to 64BIT (Uwe)
> - Add a math module with div64_u64() and div64_u64_round_up()
> - Drop Cc: stable and the Reviewed-by tags, since the change is different
> v2: https://lore.kernel.org/rust-for-linux/20260930101257.1649945-1-tomo@flapping.org/
> - Fix a typo in the commit message
> - Add Cc: stable, Reported-by and Closes tags
> - Add Reviewed-by tags from Andreas and Gary
> - Rebase on v7.3-rc5
> v1: https://lore.kernel.org/all/20260929095612.1072417-1-tomo@flapping.org/
> 
> FUJITA Tomonori (2):
>   rust: math: add div64_u64() and div64_u64_round_up()
>   pwm: th1520: Fix 32-bit build with COMPILE_TEST
> 
>  drivers/pwm/pwm_th1520.rs |  8 +++--
>  rust/kernel/lib.rs        |  1 +
>  rust/kernel/math.rs       | 71 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 78 insertions(+), 2 deletions(-)
>  create mode 100644 rust/kernel/math.rs

Gentle ping.

Could you take a look at patch 2? Are you OK with this series going
through the Rust tree?
