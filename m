Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788E4390998;
	Thu, 30 Jul 2026 14:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785420225; cv=none; b=IxeDX+9WtBKejGL1iPmUPwrLOaLuA+31n35OzS2b+NBBkG44eCILWIYP7lPClFkDKFkPYqrTKfL9F++MUd15EVCNvZbYNNkaoUmxByzmqXeFgRDlcwDDhU/5F0H7jUYgdy5PYk0EG95ULbikW8dQRJ1QoWcU0xbcU9AQf73r+0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785420225; c=relaxed/simple;
	bh=XllOdqIxgg1wFPbi03Ykg9ZhFcREfOlQVJEldOvzTDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WLA/F5Ju9Yis9HKnjhWFaoVD/cunZ/pY020srgtlLQNIv4/8aAVoWUn/oiSTxwSi6eh0jM1RdpQ3aQahrEG7tIbf6j/e8a/QWFn+GNAHtO9fW+LK/+eMs1WL/9kT+h0VJkSXGeUx3p58IedyItpdq624WXIgvYZSNOQDb6P/1J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HfOK/I4o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HfOK/I4o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A601F000E9;
	Thu, 30 Jul 2026 14:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785420224;
	bh=xo9SFnEMqa+KhEhw5FBGgziKLHD5HpEA1bUfDJGjZWo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=HfOK/I4o9sZ3OdPDt3cShFxXnLS1hGZYHo8xEU0im9XOopNgAWGNKJpZIkSEF+QRU
	 BseQ/6GSOF11YkPyP/nu46tGlLRXnAXKnKRHQ5fmKySxYw1FVvJk9kmpcSx+aaAZgc
	 GOVvEhNiL1haAVEWVdZnhBw9hY2gyJWSRi4QTQiYvoqBXPUKph6b4zn0n5ZyfQGP/q
	 PMaCwyOUtWHpy4xFbs9VFKfIJT7TT+zoAdU9tXwBtGTWVhOLQyJ6U+Zu8Foc3QAMo3
	 86+thW9h4yn1AC22cs0rC/9Iswqd7XJiRB4OvDGViteX7t9sp3cyIknCip4VtFQnXk
	 9UOR1FkcKB9GA==
Message-ID: <863d5c09-d8bc-4241-a464-cb989e0dfc46@kernel.org>
Date: Thu, 30 Jul 2026 16:03:39 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] rust: treewide: replace `__pinned_init` with
 `ptr_[try_]init`
To: Gary Guo <gary@garyguo.net>
Cc: Benno Lossin <lossin@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Michal Wilczynski <m.wilczynski@samsung.com>,
 rust-for-linux@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260729-merge-init-v2-0-26adf47109e7@garyguo.net>
 <20260729-merge-init-v2-4-26adf47109e7@garyguo.net>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20260729-merge-init-v2-4-26adf47109e7@garyguo.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/26 5:38 PM, Gary Guo wrote:
> The `__init` method is not designed to be a public API (existence of "__"
> is a hint for this); replace users with `pin_init::ptr_[try_]init` which
> does the same thing.
> 
> There are a few users of `__init` which are replaced as well.
> 
> Signed-off-by: Gary Guo <gary@garyguo.net>


Acked-by: Danilo Krummrich <dakr@kernel.org>
