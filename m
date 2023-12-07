Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87F815B9;
	Thu,  7 Dec 2023 02:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eX+/7lKe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5BAC433C7;
	Thu,  7 Dec 2023 02:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701914852;
	bh=zstazvCMMHfwLwcPLvuGpXLbRdo7SdLHmBImK7piuno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eX+/7lKebn5pDRsCSgpJ9IW35eHjnchnEU+ckcnG6xndBOk22iBMJfyxlBevRbczb
	 JySzHE73idVtSJmcxzuve28cBG+R+YYcQpsqf5Y1ly8UKVpbk29/fri37VeXGn7jF1
	 UaGpuZ3Q/9nv19aR1A+Pzg3fNRh5w2zz8Sa4CjALEzlZ5sO4zx+hXfoeqjmQRyp+/C
	 dybZlKaOnpzcIY74dHyqR6amwQ7QNvQptkKeYfipGR++27O8hrR5kpmLatztPn9wKu
	 xVinxD28Rhvt9pVyEfp94j6Q60XIj5gukcxssXb0yZAivhzry/Ld2hgXFeXaQqPCkl
	 r5jjzk6foFxcg==
Date: Thu, 7 Dec 2023 10:07:29 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>, linux-pwm@vger.kernel.org,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH v4 057/115] pwm: cros-ec: Make use of
 devm_pwmchip_alloc() function
Message-ID: <ZXEo4Zehi8OedkOa@google.com>
References: <cover.1701860672.git.u.kleine-koenig@pengutronix.de>
 <d86e0bbcc2ddd4dea8370640987458e6e0a9e6d6.1701860672.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d86e0bbcc2ddd4dea8370640987458e6e0a9e6d6.1701860672.git.u.kleine-koenig@pengutronix.de>

On Wed, Dec 06, 2023 at 12:44:11PM +0100, Uwe Kleine-König wrote:
> This prepares the pwm-cros-ec driver to further changes of the pwm core
> outlined in the commit introducing devm_pwmchip_alloc(). There is no
> intended semantical change and the driver should behave as before.
> The probe function had to be changed a bit because the number of PWMs
> must be determined before allocation of the pwm_chip and its private
> data now.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
