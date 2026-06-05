Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822D244CF56;
	Fri,  5 Jun 2026 07:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780642867; cv=none; b=McemWhimCrei2vFKhB0AJF00lJ3Coqmzc56Oye0le/XH87SnHw1YMjG/VYbj0VjFh0pv2RflVecPaYuYz1kSGjouR8cpaQUOO47JSPJU0hjkGv1xq97+xQ8GDYD3vvP6U0dRFcztflTg4gqSmfHEsm863LGHBqyi6hTvATpnBHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780642867; c=relaxed/simple;
	bh=7AgV/jvCGRHNYi9UE7Sn1mIc5P3fU81aRL5N8wcCv8w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=q9VYV//ERCNDvE6zpDKwqHgeB6W2/zjf3eRAEznS+nClD77eZSpgQ72o9hYP761mTu0aHNG0Zx8Pwve4L4WVluxOpr2XPwDOmB3VfgSvefwXzgSHMVkVEh3DuF964gwYibdD0GVVfivjDd3nd45YEVjEbsAFI9muAFYOjbcD3yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=KGElozfF; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=B9mdvrtu; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="KGElozfF";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="B9mdvrtu"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gWslr1N5Rz9v9m;
	Fri,  5 Jun 2026 09:00:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1780642856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ok3grrEVy8++TcZAk4/8hJa1q3Dyot3JENfiZb1Bh5o=;
	b=KGElozfFeWoSUsHggk+MGm+Gcj/16XxxmZFWnXSyx/iDqA4qmePnJkRBrcLNuZUQfz3WXs
	7TDnmxPE5FZvWurzHyoL70eaChcwMsfithUyOUj5LngmS1CVEtZUMGCLQUc29Xz/nU7KbB
	YJFxRqpYAG+AynG6wglcARBC6UKLv8CFIFx2FOJtL2CxIzQjOmzu9XBc5b/IU0fVWQsOHe
	NhtFTN94hezfxPkKdTBUDjx4iE1Rw+b8yMyjZEldjqgkJp23+HvcdpH5FYSkNXbhoCDVC1
	79QKmCAk8n2Z4e7AOFa50Ise4DVyaIoT6FUUITF3pucVC1d33BBqbNkheF1ksg==
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1780642849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ok3grrEVy8++TcZAk4/8hJa1q3Dyot3JENfiZb1Bh5o=;
	b=B9mdvrtulAX0Myi4wyYoU9wm7PAZ/NE1gKqig0Feg/z6bQnOM0LWswaDKoDYgppGMk6NAA
	fLaokrGDJ7hBUpPhUQVNwjZ+/grao7zF0Ob2uB2cS6MGVykNo6kCkHQNPvz4/61Zj4+ydt
	TBUjARVdHYkVU6M9R2W1Ds6z8BLmw+8qHc5e0pIfXvcMZ8H2XH7+FSBUoe+jFErQ6Ju210
	co8hpJFXEtwUlUzrtyFYiXRF6dH3am6hfP8dxlhPs1GtPRWF5NDSzv4JyabBMOhS5iTydi
	7nh2NRFRxcTQLEdnF2FFHrG3P6Crji6rW5eoRy9m/yPVARPDKGm9Kvq4IU2PhA==
Subject: [PATCH v2 0/2] rust: clk: Add ExclusiveClk and use it in
 pwm-th1520
Date: Fri, 05 Jun 2026 08:59:58 +0200
Message-Id: <20260605-rate-exclusive-get-th1520-v2-0-695640bf7249@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQ6CMBBFr0Jm7Zi2FBRX3sOwqDDAJEhJW5saw
 t2tnMDl+8l/bwNPjsnDrdjAUWTPdsmgTgV0k1lGQu4zgxKqFpWq0ZlASKmb354j4UgBwyQrJfB
 Sa9Popid5Jcj/1dHA6XA/2swT+2Dd50hF+Vv/sUaJAkvdDaLUJHPj/jI8P206WzdCu+/7FzTEv
 qnEAAAA
X-Change-ID: 20260526-rate-exclusive-get-th1520-764a949de18e
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Drew Fustini <fustini@kernel.org>, 
 Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
 Michal Wilczynski <m.wilczynski@samsung.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-pwm@vger.kernel.org, Maurice Hieronymus <mhi@mailbox.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780642818; l=1057;
 i=mhi@mailbox.org; s=20260525; h=from:subject:message-id;
 bh=7AgV/jvCGRHNYi9UE7Sn1mIc5P3fU81aRL5N8wcCv8w=;
 b=MQ9ALBSr14fgkGxYrTIqDCq8RAvbwrzksThQHaFqK0YN3At+av9LQpU5i58S2+6cLMboqKJdq
 63OUxc1rFroDOE3wkR5hTTdLetppbU/ymDT5LtloDUS5JF8zEvQySOD
X-Developer-Key: i=mhi@mailbox.org; a=ed25519;
 pk=AHlEkGG3hpXZHntlEzF42Ip/LFyXWOgsNUvaHqAnV80=
X-MBO-RS-META: pqwz9dnzqb5jncw8f6pzxerow7tykiuk
X-MBO-RS-ID: a64c37f4287a6ee13a7

Add a Rust binding for clk_rate_exclusive_get() / clk_rate_exclusive_put()
and use it in pwm-th1520, which previously carried a TODO noting the
missing binding.

Based on pwm/for-next.

Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
Changes in v2:
- Rebase on pwm/for-next
- Remove newline after [`clk_rate_exclusive_get`] comment
- Remove unused [`struct clk`] link
- Put semicolon outside of unsafe block
- Link to v1: https://lore.kernel.org/r/20260526-rate-exclusive-get-th1520-v1-0-34cf034e1764@mailbox.org

---
Maurice Hieronymus (2):
      rust: clk: Add ExclusiveClk wrapper for clk_rate_exclusive_get
      pwm: th1520: Lock clock rate with clk_rate_exclusive_get

 drivers/pwm/pwm_th1520.rs |  8 +++----
 rust/kernel/clk.rs        | 60 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 5 deletions(-)
---
base-commit: 5b5e33c44a491d5b5e019f527e028bd567a226fa
change-id: 20260526-rate-exclusive-get-th1520-764a949de18e

Best regards,
-- 
Maurice Hieronymus <mhi@mailbox.org>

