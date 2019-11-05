From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [GIT PULL] pwm: Fixes for v5.4-rc6
Date: Tue, 5 Nov 2019 22:31:27 +0100
Message-ID: <20191105213127.gyxc2shjz2nq7ul5@pengutronix.de>
References: <20191102134800.3847540-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191102134800.3847540-1-thierry.reding@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hello Thierry,

On Sat, Nov 02, 2019 at 02:48:00PM +0100, Thierry Reding wrote:
> The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:
> 
>   Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.4-rc6
> 
> for you to fetch changes up to 40a6b9a00930fd6b59aa2eb6135abc2efe5440c3:
> 
>   Revert "pwm: Let pwm_get_state() return the last implemented state" (2019-10-21 16:48:52 +0200)
> 
> Thanks,
> Thierry
> 
> ----------------------------------------------------------------
> pwm: Fixes for v5.4-rc6
> 
> It turned out that relying solely on drivers storing all the PWM state
> in hardware was a little premature and causes a number of subtle (and
> some not so subtle) regressions. Revert the offending patch for now.
> 
> ----------------------------------------------------------------
> Thierry Reding (1):
>       Revert "pwm: Let pwm_get_state() return the last implemented state"

In a different thread on the pwm mailing list I suggested to add

	pwm: bcm-iproc: prevent unloading the driver module while in use

to this pull request. You didn't comment and didn't add it. :-|
(https://patchwork.ozlabs.org/patch/1178972/)

While this is not a recent regression (it was introduced in 4.8-rc1) I
think it's still worth to be fixed, don't you agree?
 
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
