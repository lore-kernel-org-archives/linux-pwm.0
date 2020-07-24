From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH V17 3/3] Input: new da7280 haptic driver
Date: Thu, 23 Jul 2020 22:48:47 -0700
Message-ID: <0f604bb1-f8b8-b262-c8ae-b346755b99f1@infradead.org>
References: <cover.1595516501.git.Roy.Im@diasemi.com>
 <c13d812871b7f09205c1f04e95f5bdf07f307eaf.1595516501.git.Roy.Im@diasemi.com>
 <71818ab8-0020-77db-c412-8d35a541ead3@infradead.org>
 <DB8PR10MB343644A6DADE61D62BEE157C85770@DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM>
 <f549102d-4e69-c903-1672-f50bdb7994a3@infradead.org>
 <DB8PR10MB343624BF003338E8B34439AC85770@DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <DB8PR10MB343624BF003338E8B34439AC85770@DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Roy Im <roy.im.opensource@diasemi.com>, Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Brian Masney <masneyb@onstation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Lee Jones <lee.jones@linaro.org>, Luca Weiss <luca@z3ntu.xyz>, Maximilian Luz <luzmaximilian@gmail.com>, Pascal PAILLET-LME <p.paillet@st.com>, Rob Herring <robh@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Support Opensource <Support.Opensource@diasemi.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

On 7/23/20 10:47 PM, Roy Im wrote:

> OK, thanks for your comments. To be clearer, I would like to update as below if you agree
> 	
> 	depends on INPUT && I2C
> ...
> 	The haptics can be controlled by PWM or GPIO
> 	with I2C communication.

Yes, that sounds good. Thanks.

-- 
~Randy
