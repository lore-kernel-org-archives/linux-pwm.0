Return-Path: <sachin.kamat@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20131008135020.GA16550@ulmo.nvidia.com>
References: <1380511601-20977-1-git-send-email-sachin.kamat@linaro.org>
	<20131008135020.GA16550@ulmo.nvidia.com>
Date: Tue, 8 Oct 2013 20:54:22 +0530
Message-ID: <CAK9yfHwSNPZpsyg75nO4pKdpku7KXTyRnTeXHO0mGca=P4z-ZA@mail.gmail.com>
Subject: Re: [PATCH 1/3] pwm: mxs: Remove redundant of_match_ptr
From: Sachin Kamat <sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org

On 8 October 2013 19:20, Thierry Reding <thierry.reding@gmail.com> wrote:
> On Mon, Sep 30, 2013 at 08:56:39AM +0530, Sachin Kamat wrote:
>> The data structure of_match_ptr() protects is always compiled in.
>> Hence of_match_ptr() is not needed.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> Cc: Shawn Guo <shawn.guo@linaro.org>
>> ---
>>  drivers/pwm/pwm-mxs.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Applied (the series), thanks.
>

Thanks Thierry.


-- 
With warm regards,
Sachin
