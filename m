Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792501487;
	b=19BkDP+pdmRtMMn63aIBWwQEvqi2YT9Hfjw/rD4i6KryyA9o15+ZtmNRA6OgD8ikr+ZH
	 xGAUQO51s+k7nAVmP5ZBKC/5a6W7i3bKs8vViB23ZNe6RkMq5QgJ5/7RKq3YyB1zzLJY7
	 /j4YqjfHNopKgNGvGM+Dl8L5N3eBs9vMH+dGsLBk33/O91fYjWAA8xrjRiR+DffFBXtbE
	 wwijhNP8SrSvcN92vnfrDvkLtUObvOjMhqwqJw9RBIV9f6m5AJMmC2G57SctIGiX0jEnE
	 bMF4dUy1maSRWsgf7uj1rGgtQSJxAVT54TQ0Ge/DsvlqR/DikaPx+nfur4hQhr27YqA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792501487;
	h=DMARC-Filter:DKIM-Signature:Received:Content-Type:Mime-Version:
	 Subject:From:In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:
	 References:To:X-Mailer:X-ZohoMailClient;
	bh=60yzROzme+I8oXG1X8cG4tnHO5f5LLKhunxRbjPCyxw=;
	b=TRQ24zIvN34nrL+8B6ypFe8dQmr82H1NOZrwnkhiur/gQ3UtAUEhRu7NxIMLlsDyAQu9
	 uV+vurQjVOY3vj9IFZFy+ri8UEHomadG58FNTgWNYPG9FFDfO1K3qnf5KWqXT2UF1Rww4
	 5PjJkgT42GplR53WrrDvJdvDGp2ASQuhINx4mRca4tVRPpjO+M4sIP4JrfRDf4cR81tiG
	 iivMPuXw8QOuvNFLAjTTTseSbP9quwKWnmL4fyvVRhyNYjPoq8MefJl7M+PF3RHPpUARX
	 +wIqObQCL0CkMXHHmEHxXNcW2trI88ggC0GWR789HD+vZkGh4AtBhtHMWXefH2kbX4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=daniel.almeida@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=hxzfNk2G;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D509606A319;
	Tue, 20 Oct 2026 13:04:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D509606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=hxzfNk2G
ARC-Seal: i=1; a=rsa-sha256; t=1792501449; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fWnXbwa8JLtt61TkI+u2U22uYOVL1FMZfCRinthKZiu2rgwJQWQGmKuptFwrJRhzyRZbBvKOLTY+9I69wSWHPdTBgpwVGOM2uTWbzqInopmDYEg7s/lftjBdO2OYu5MY6BE4zcz9EcN+zMneKPIdzRBqh4edHHCObobh2aE8EjU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792501449; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=60yzROzme+I8oXG1X8cG4tnHO5f5LLKhunxRbjPCyxw=; 
	b=Wq+sEjzawdc3he6bhmx2rrIVcwB8VxkKMVkvSR1kzOAQE7ftGy5Vd1ccZq9eM3EY/BVUH+sTq8aIcwXXxTZCHO/Tx9cSEOJ0rjdDfzckDO7uMITAoUTpNjfi8FEfbkRNmzbwOUK7m3uatDdK3aSjU1WMPV6QS+V++OBDpdnntl8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792501449;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Reply-To;
	bh=60yzROzme+I8oXG1X8cG4tnHO5f5LLKhunxRbjPCyxw=;
	b=hxzfNk2G0UJiaJbbgHSfz558NINKje8EcCOdws8+o/pUT1VqCZdd6K2Vnxc9Ei5V
	yHEZk74LPD2TyLmwpJtK2iwzKLJwsORf92Jx3j9BQEyIJTBLWGobbNOC4lsOjNCBbrd
	d7sCVu4RCZVFc+J2RWBMK6YAun8kDl1cnQKYwIZg=
Received: by smtp.zohomail.com with SMTPS id 1792501446453909.1476462693812;
	Tue, 20 Oct 2026 06:04:06 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: Re: [PATCH v4 0/2] rust: clk: Add ExclusiveClk and use it in
 pwm-th1520
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <atdlfNRiza3gA1iD@monoceros>
Date: Tue, 20 Oct 2026 10:03:47 -0300
Cc: Maurice Hieronymus <mhi@mailbox.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Drew Fustini <fustini@kernel.org>,
 Guo Ren <guoren@kernel.org>,
 Fu Wei <wefu@redhat.com>,
 Michal Wilczynski <m.wilczynski@samsung.com>,
 Brian Masney <bmasney@redhat.com>,
 linux-clk@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org,
 linux-pwm@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8625DA25-1F59-4175-81A6-BAA16C961557@collabora.com>
References: <20260711-rate-exclusive-get-th1520-v4-0-8244a0666a71@mailbox.org>
 <atdlfNRiza3gA1iD@monoceros>
To: =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.11)
X-ZohoMailClient: External



> On 20 Oct 2026, at 09:59, Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org> =
wrote:
>=20
> Hello,
>=20
> On Sat, Jul 11, 2026 at 12:16:28PM +0200, Maurice Hieronymus wrote:
>> Add a Rust binding for clk_rate_exclusive_get() / =
clk_rate_exclusive_put()
>> and use it in pwm-th1520, which previously carried a TODO noting the
>> missing binding.
>>=20
>> Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
>> ---
>> [...]
>> ---
>> Maurice Hieronymus (2):
>>      rust: clk: Add `ExclusiveClk` wrapper for =
`clk_rate_exclusive_get`
>>      pwm: th1520: Lock clock rate with clk_rate_exclusive_get
>>=20
>> drivers/pwm/pwm_th1520.rs | 18 ++++++++-----
>> rust/kernel/clk.rs        | 67 =
+++++++++++++++++++++++++++++++++++++++++++++++
>> 2 files changed, 79 insertions(+), 6 deletions(-)
>> ---
>> base-commit: 92010229c4b38897f1319d260162d2f96925ed17
>> change-id: 20260526-rate-exclusive-get-th1520-764a949de18e
>> prerequisite-change-id: 20250909-clk-type-state-c01aa7dd551d:v5
>> prerequisite-patch-id: 2d3dc45c241d9062a0d2546ec649eec7970fa50a
>> prerequisite-patch-id: 67ad535fe110207ebc79045ba022ebb7137b0309
>> prerequisite-patch-id: 3d1d8ee5c2a4957edd0807b7a5cb65dabab345b5
>> prerequisite-patch-id: e2659037b8aaf51831da099cc568ad5b3c24a4dd
>=20
> I didn't track these dependencies, but the change looks fine for me. =
Who
> is supposed to merge it? I can take it via pwm, but I guess a rust =
tree
> is more appropriate?!
>=20
> Best regards
> Uwe

Please no,

See [0] instead, which also includes a newer version of this patch.

[0]: =
https://lore.kernel.org/rust-for-linux/20261013-clk-type-state-v6-1-a5e997=
7b3509@collabora.com/

