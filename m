Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C61035676A;
	Tue, 11 Aug 2026 21:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786483051; cv=none; b=tEVKEy6i3o6e0k98UY2XoA3yllTx6vJky3aDOH19isNzR/LjmuAwE720JE9PhL6bzjEdbU6h7D+wFIro8oHxcHltKj60DxPJanZupzQss4RZLr2lp1lF6dZrlWb8nrpFID95T4raq1PsvR7n30zyWNlSqM8KG7oBtefzwQm5zhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786483051; c=relaxed/simple;
	bh=ebQzgh0vBvXvLeVlXwS7Pm1/HOi/G/gjQQbtBNsEW5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SI8hZKG7SWewGhRfeLGH6xE1UMdDjQTmSDzi7p6xXqXWL1x180EkXUcbNC0Lkn4r/ld6IfQV2mggyIDmYpx+Ks8tWvSbDfwGj6CZlSd/f9hp7xoGxDiX41u4rBSnzgS+LaO+g663RwAvDuedXfIsPYngMmeXRlEaR8qrrMRN47Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrL3jAHx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrL3jAHx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E55541F000E9;
	Tue, 11 Aug 2026 21:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786483050;
	bh=xvp02moGcrU1G7UiUVcwIPIznMhC+B6E/q/bBG02qkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MrL3jAHx8nDsygbWIiCNOjMsbgum7NTclyu+xVGTMx4pUwFMaXdUPHFte5DP01kG7
	 wlW6VflMU2yLiudP4InktyqCY0t3//070dQguSaP+/M6P8rH9KxhFWRDQ1uN4NbPEJ
	 DvuDRYtDokkMVq0zeanhd9KbaXpkLNjOF25SmRzDYfSnhE0jpMrLKchMjMNBopmcXe
	 eVB4wGFscdo/AJ2pYYmICh3jMFeWGNMiVM4969P8g4cfxIzOxuMXCwYc4yV21FzTDg
	 ToKkde1vwLXMlVkNXCh7UkZtTOAmyv+iKIlS+70UlGIBR1AwOsWJaO/P/oo1rCUS9L
	 NFq2yVRboI/bA==
Date: Tue, 11 Aug 2026 17:17:27 -0400
From: Konstantin Ryabitsev <mricon@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Francis Laniel <laniel_francis@privacyrequired.com>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
	Alexandre Courbot <acourbot@nvidia.com>, Boqun Feng <boqun@kernel.org>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tools@kernel.org
Subject: Re: [PATCH v3] rust: pwm: replace `core::mem::zeroed` with
 `pin_init::zeroed`
Message-ID: <20260811-famous-convivial-iguana-d4b104@meerkat>
References: <20260603160910.159307-1-laniel_francis@privacyrequired.com>
 <anqsTVj5QGYGiEQ9@monoceros>
 <20260811-garrulous-serpent-of-agreement-cf9b19@meerkat>
 <CANiq72mb0RK=2Oaipzas9UZQiEy7FW331dosH0+cFKuVQNE6Hw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANiq72mb0RK=2Oaipzas9UZQiEy7FW331dosH0+cFKuVQNE6Hw@mail.gmail.com>

On Tue, Aug 11, 2026 at 11:00:54PM +0200, Miguel Ojeda wrote:
> > I added a special case where we ignore trailers we find in the follow-up if
> > these trailers already exist in the patch anyway, so, at least for this
> > particular case, the problem shouldn't resurface.
> 
> Hmm... I usually indent with 2 or 4 spaces my "non-tags" to
> distinguish them from actual tags; perhaps I should mark them
> differently? Is there a "standard" prefix to ignore them instead of
> several spaces?

Unfortunately, some prominent maintainers indent their code review trailers,
which is why we have to pay attention to those.

I generally recommend using "|" when adding trailers that aren't part of
actual code review, e.g.:

| Fixes: abcde12345 ("Foo bar baz")
| Reviewed-by: Alex Dev <adev@example.com>

These are guaranteed to be ignored.

-K
